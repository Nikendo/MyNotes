//
//  NewNoteViewModel.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 10.05.2023.
//

import Foundation
import Combine

@MainActor
final class NoteScreenViewModel: ObservableObject {

  // MARK: - Private Propertie
  
  private let model: NoteScreenModel
  private let id: UUID
  private var note: Note
  
  // MARK: - Publishers

  @Published var noteViewState: ViewState
  @Published private(set) var destination: Flow.Destination = .none
  @Published private(set) var canSave: Bool = false
  
  @Published var date: Date
  @Published var mood: Mood
  @Published var title: String
  @Published var message: String
  
  // MARK: - Init

  init(
    model: NoteScreenModel,
    note: Note,
    isPreview: Bool = false
  ) {
    self.model = model
    self.note = note
    self.id = note.id
    self.date = note.date
    self.mood = note.mood
    self.title = note.title
    self.message = note.message
    self.noteViewState = isPreview ? .preview : .new(filled: false)
  }

  func save() {
    self.note = Note(id: id, date: date, mood: mood, title: title, message: message)
    Task {
      do {
        try await model.saveNote(note: note)
        destination = .save
      } catch {
        print(error.localizedDescription)
      }
    }
  }
    
  func switchToEditMode() {
    noteViewState = .edit(filled: canSave)
  }

  func cancel() {
    destination = .cancel
  }
  
  func bindInput() {
    $title.combineLatest($message).map { !$0.0.isEmpty || !$0.1.isEmpty }.assign(to: &$canSave)
    $canSave.map { [weak self] in
      guard let self else { return ViewState.new(filled: $0) }
      return switch noteViewState {
      case .edit: ViewState.edit(filled: $0)
      case .new: ViewState.new(filled: $0)
      case .preview: ViewState.preview
      }
    }
    .assign(to: &$noteViewState)
  }
}
