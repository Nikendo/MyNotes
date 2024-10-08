//
//  NoteScreenView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 29.01.2023.
//

import SwiftUI

struct NoteScreenView: View {

  // MARK: - Environments

  @Environment(\.dismiss) var dismiss

  // MARK: - Private Properties

  @StateObject private var viewModel: NoteScreenViewModel
  @State private var titleHeight: CGFloat = 0
  @State private var messageHeight: CGFloat = 0
    
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
    .onReceive(viewModel.$destination) { destination in
      switch destination {
      case .save, .cancel: dismiss()
      case .none: break
      }
    }
  }
}

private extension NoteScreenView {

  // MARK: - Subviews

  var backgroundView: some View {
    Color(.D_9_E_8_FD).ignoresSafeArea()
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
        .foregroundStyle(Color(._64696_F))
        .labelStyle(.iconOnly)
        .padding()
      
      Spacer()
      
      Button(
        viewModel.noteViewState == .preview ? "Edit" : "Save",
        systemImage: viewModel.noteViewState == .preview ? SystemIcons.edit.name : SystemIcons.accept.name,
        action: viewModel.noteViewState == .preview ? viewModel.switchToEditMode : viewModel.save      )
      .foregroundStyle(Color(._64696_F).opacity(viewModel.canSave ? 1.0 : 0.6))
      .labelStyle(.titleAndIcon)
      .padding()
      .disabled(!viewModel.canSave)
    }
  }

  var closeView: some View {
    Button("Close", systemImage: SystemIcons.close.name, action: viewModel.cancel)
      .foregroundStyle(Color(._64696_F))
      .labelStyle(.iconOnly)
      .padding()
  }

  var searchView: some View {
    Image(systemName: SystemIcons.search.name)
      .foregroundStyle(Color(._64696_F))
      .padding()
  }

  var saveView: some View {
    Button(action: viewModel.save) {
      Text("Save")
    }
    .foregroundStyle(Color(._64696_F).opacity(viewModel.canSave ? 1.0 : 0.6))
    .padding()
    .disabled(!viewModel.canSave)
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
      selection: $viewModel.model.date,
      displayedComponents: .date,
      label: {
        EmptyView()
      }
    )
    .labelsHidden()
    .padding()
    .disabled(viewModel.noteViewState == .preview)
  }

  var moodPickerView: some View {
    Picker(
      selection: $viewModel.model.mood,
      content: {
        ForEach(NoteModel.Mood.allCases, id: \.self) {
          Text($0.rawValue)
            .font(.system(size: 20))
        }
      },
      label: {
        ZStack {
          Circle().opacity(0.1)
            .frame(maxWidth: 40)
          Text(viewModel.model.mood.rawValue)
            .font(.system(size: 20))
        }
        .padding()
      }
    )
    .accentColor(Color(._64696_F))
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
    ZStack(alignment: .topLeading) {
      Text(viewModel.model.title)
        .font(.body)
        .foregroundStyle(Color(._101010))
        .opacity(0)
        .lineSpacing(8)
        .background {
          GeometryReader { geometry in
            Color.clear.onAppear {
              print("Title height: \(geometry.size.height)")
              self.titleHeight = geometry.size.height
            }
          }
        }
      
      if viewModel.model.title.isEmpty && viewModel.noteViewState != .preview {
        Text("Title")
          .font(.title)
          .fontWeight(.semibold)
          .foregroundStyle(Color(.A_7_B_1_C_0))
          .padding(.top, 8)
          .padding(.leading, 4)
      }
      
      TextEditor(text: $viewModel.model.title)
        .font(.title)
        .fontWeight(.semibold)
        .foregroundStyle(Color(._101010))
        .scrollContentBackground(.hidden)
        .frame(minHeight: viewModel.model.title.isEmpty ? 48 : titleHeight)
        .disabled(viewModel.noteViewState == .preview)
    }
  }

  var messageView: some View {
    ZStack(alignment: .topLeading) {
      Text(viewModel.model.message)
        .font(.body)
        .foregroundStyle(Color(._101010))
        .opacity(0)
        .lineSpacing(8)
        .background {
          GeometryReader { geometry in
            Color.clear.onAppear {
              self.messageHeight = geometry.size.height
            }
          }
        }
      
      if viewModel.model.message.isEmpty && viewModel.noteViewState != .preview {
        Text("Write here...")
          .font(.body)
          .foregroundStyle(Color(.A_7_B_1_C_0))
          .padding(.top, 8)
          .padding(.leading, 4)
      }
      
      TextEditor(text: $viewModel.model.message)
        .font(.body)
        .foregroundStyle(Color(._101010))
        .scrollContentBackground(.hidden)
        .frame(minHeight: viewModel.model.message.isEmpty ? 32 : messageHeight)
        .disabled(viewModel.noteViewState == .preview)
    }
  }
}

struct NewNoteView_Previews: PreviewProvider {
  static var previews: some View {
    NoteScreenView(viewModel: .init(createCompletion: {_ in }))
    NoteScreenView(viewModel: .init(
      noteModel: .init(
        id: UUID(),
        date: Date(),
        mood: .normal,
        title: "Multilined\nText\nFor this\nnote",
        message: "Multy\nMylty\nMultilined description\nFor\nThis note"
      ),
      isPreview: true,
      createCompletion: { _ in }
    ))
  }
}
