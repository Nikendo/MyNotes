//
//  NoteListView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

import SwiftUI

struct NoteListView: View {
  @EnvironmentObject private var appSettings: AppSettings
  @StateObject private var viewModel: NoteListViewModel
  private let saveNoteUseCase: SaveNoteUseCase
  
  init(viewModel: NoteListViewModel, saveNoteUseCase: SaveNoteUseCase) {
    _viewModel = StateObject(wrappedValue: viewModel)
    self.saveNoteUseCase = saveNoteUseCase
  }
  
  var body: some View {
    NavigationStack(path: $viewModel.navigationPath) {
      List {
        Group {
          contentHeaderView
          notesList
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
      }
      .navigationDestination(for: NoteListViewModel.NavigationCase.self) { navCase in
        switch navCase {
        case let .note(note):
          NoteScreenBuilder(saveNoteUseCase: saveNoteUseCase, note: note, isPreview: true).build()
        case .newNote:
          NoteScreenBuilder(saveNoteUseCase: saveNoteUseCase).build()
        }
      }
      .listStyle(.inset)
      .scrollContentBackground(.hidden)
      .listRowSpacing(16)
      .background(appSettings.appTheme.backgroundColor)
      .ignoresSafeArea(.container)
      .customNavigationBar(searchableText: $viewModel.searchableText)
      .customBottomNavigationbar {
        viewModel.navigateToNewNote()
      }
    }
    .onAppear(perform: viewModel.bindInput)
    .onChange(of: viewModel.navigationPath) {
      viewModel.refreshData()
    }
    .task {
      await viewModel.fetchAllNotes()
    }
  }
  
  private var contentHeaderView: some View {
    appSettings.appTheme.image
      .resizable()
      .scaledToFit()
  }
  
  private var notesList: some View {
    ForEach(appSettings.notesOrder == .reversed ? viewModel.notes.reversed() : viewModel.notes, id: \.hashValue) { note in
      NoteCellView(note: note)
        .padding(.horizontal)
        .onTapGesture {
          viewModel.navigateToExistedNote(note: note)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
          Button(
            role: .destructive,
            action: { viewModel.deleteNoteUseCase(note: note) },
            label: { Label("Delete", systemImage: "trash") }
          )
          .tint(appSettings.appTheme.backgroundColor)
        }
    }
  }
}

import SwiftData

#Preview {
  let repository: NoteRepository = NoteRepositoryImpl(modelContext: ModelContext(previewContainer))
  let navPath: NavigationPath = NavigationPath()
  let view = NavigationStack {
    NoteListView(
      viewModel: NoteListViewModel(
        model: NoteListModel(
          fetchAllNotesUseCase: FetchAllNotesUseCaseImpl(repository: repository),
          deleteNoteUseCase: DeleteNoteUseCaseImpl(repository: repository)
        ),
        navigationPath: navPath
      ),
      saveNoteUseCase: SaveNoteUseCaseImpl(repository: repository)
    )
  }
  .environmentObject(AppSettings())

  return view
}
