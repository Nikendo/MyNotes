//
//  NoteScreenView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 29.01.2023.
//

import SwiftUI

struct NoteScreenView: View {

  // MARK: - Environments

  @EnvironmentObject private var appSettings: AppSettings
  @Environment(\.dismiss) var dismiss

  // MARK: - Private Properties

  @StateObject private var viewModel: NoteScreenViewModel
    
  // MARK: - Init

  init(viewModel: @autoclosure @escaping () -> NoteScreenViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel())
  }

  // MARK: - Body

  var body: some View {
    ZStack {
      backgroundView
      contentView
    }
    .onAppear(perform: viewModel.bindInput)
    .onReceive(viewModel.$destination) { destination in
      switch destination {
      case .save, .cancel: dismiss()
      case .none: break
      }
    }
    .navigationBarBackButtonHidden()
  }
}

private extension NoteScreenView {

  // MARK: - Subviews

  var backgroundView: some View {
    appSettings.appTheme.primaryContainerColor.ignoresSafeArea()
  }

  var contentView: some View {
    ScrollView {
      VStack {
        headerView
        subheaderView
        textsView
        Spacer()
      }
    }
  }

  var headerView: some View {
    HStack {
      Button("Close", systemImage: SystemIcons.close.name, action: viewModel.cancel)
        .foregroundStyle(appSettings.appTheme.onPrimaryContainerColor)
        .labelStyle(.iconOnly)
        .padding()
      
      Spacer()
      
      Button(
        viewModel.noteViewState == .preview ? "Edit" : "Save",
        systemImage: viewModel.noteViewState == .preview ? SystemIcons.edit.name : SystemIcons.accept.name,
        action: viewModel.noteViewState == .preview ? viewModel.switchToEditMode : viewModel.save      )
      .foregroundStyle(appSettings.appTheme.onPrimaryContainerColor.opacity(viewModel.canSave ? 1.0 : 0.6))
      .labelStyle(.titleAndIcon)
      .padding()
      .disabled(!viewModel.canSave)
    }
  }

  var subheaderView: some View {
    HStack(spacing: 0) {
      datePickerView
      Spacer()
      moodPickerView
    }
  }

  var datePickerView: some View {
    DatePicker(
      selection: $viewModel.date,
      displayedComponents: .date,
      label: {
        EmptyView()
      }
    )
    .labelsHidden()
    .padding()
    .tint(appSettings.appTheme.onPrimaryContainerColor)
    .disabled(viewModel.noteViewState == .preview)
  }

  var moodPickerView: some View {
    Picker(
      selection: $viewModel.mood,
      content: {
        ForEach(Mood.allCases, id: \.self) {
          Text($0.rawValue)
            .font(.system(size: 20))
        }
      },
      label: {
        ZStack {
          Circle().opacity(0.1)
            .frame(maxWidth: 40)
          Text(viewModel.mood.rawValue)
            .font(.system(size: 20))
        }
        .padding()
      }
    )
    .accentColor(appSettings.appTheme.onPrimaryContainerColor)
    .disabled(viewModel.noteViewState == .preview)
  }

  var textsView: some View {
    VStack(alignment: .leading) {
      titleView
      messageView
    }
    .padding(.horizontal)
    .fixedSize(horizontal: false, vertical: true)
  }

  var titleView: some View {
    TextField("Title", text: $viewModel.title, axis: .vertical)
      .font(.title)
      .fontWeight(.semibold)
      .foregroundStyle(appSettings.appTheme.onPrimaryContainerColor)
      .scrollContentBackground(.hidden)
      .lineLimit(1...5)
      .disabled(viewModel.noteViewState == .preview)
      .padding(.top, 8)
      .padding(.leading, 4)
  }

  var messageView: some View {
    TextField("Write here...", text: $viewModel.message, axis: .vertical)
      .font(.body)
      .fontWeight(.semibold)
      .foregroundStyle(appSettings.appTheme.onSecondaryContainerColor)
      .scrollContentBackground(.hidden)
      .disabled(viewModel.noteViewState == .preview)
      .padding(.top, 8)
      .padding(.leading, 4)
  }
}

import SwiftData

#Preview {
  let modelContext = ModelContext(previewContainer)
  let repository: NoteRepository = NoteRepositoryImpl(modelContext: modelContext)
  let saveNoteUseCase: SaveNoteUseCase = SaveNoteUseCaseImpl(repository: repository)

  NoteScreenBuilder(saveNoteUseCase: saveNoteUseCase).build()
    .environmentObject(AppSettings())
}

#Preview {
  let modelContext = ModelContext(previewContainer)
  let repository: NoteRepository = NoteRepositoryImpl(modelContext: ModelContext(previewContainer))
  let saveNoteUseCase: SaveNoteUseCase = SaveNoteUseCaseImpl(repository: NoteRepositoryImpl(modelContext: ModelContext(previewContainer)))
  
  NoteScreenBuilder(saveNoteUseCase: saveNoteUseCase, note: NoteEntityMock.mock, isPreview: true).build()
    .environmentObject(AppSettings())
}
