//
//  NewNoteView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 29.01.2023.
//

import SwiftUI

struct NewNoteView: View {

  // MARK: - Environments

  @Environment(\.dismiss) var dismiss

  // MARK: - Private Properties

  @StateObject private var viewModel: NewNoteViewModel


  // MARK: - Init

  init(viewModel: @autoclosure @escaping () -> NewNoteViewModel) {
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

private extension NewNoteView {

  // MARK: - Subviews

  var backgroundView: some View {
    Color("D9E8FD").ignoresSafeArea()
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
    HStack(spacing: 0) {
      closeView
      Spacer()
      searchView
      saveView
    }
  }

  var closeView: some View {
    Button("Close", systemImage: "xmark", action: viewModel.cancel)
      .foregroundStyle(Color("64696F"))
      .labelStyle(.iconOnly)
      .padding()
  }

  var searchView: some View {
    Image(systemName: "doc.text.magnifyingglass")
      .foregroundStyle(Color("64696F"))
      .padding()
  }

  var saveView: some View {
    Button(action: viewModel.save) {
      Text("Save")
    }
    .foregroundStyle(Color("64696F").opacity(viewModel.canSave ? 1.0 : 0.6))
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
    .accentColor(Color("64696F"))
  }

  var textsView: some View {
    VStack(alignment: .leading) {
      titleView
        .fixedSize(horizontal: false, vertical: true)
      messageView
        .fixedSize(horizontal: false, vertical: true)
    }
    .padding(.horizontal)
  }

  var titleView: some View {
    ZStack(alignment: .topLeading) {
      if viewModel.model.title.isEmpty {
        Text("Title")
          .font(.title)
          .fontWeight(.semibold)
          .foregroundStyle(Color("A7B1C0"))
          .padding(.top, 8)
          .padding(.leading, 4)
      }

      TextEditor(text: $viewModel.model.title)
        .font(.title)
        .fontWeight(.semibold)
        .foregroundStyle(Color("101010"))
        .scrollContentBackground(.hidden)
        .lineLimit(2)
        .frame(minHeight: 48)
    }
  }

  var messageView: some View {
    ZStack(alignment: .topLeading) {
      if viewModel.model.message.isEmpty {
        Text("Write here...")
          .font(.body)
          .foregroundStyle(Color("A7B1C0"))
          .padding(.top, 8)
          .padding(.leading, 4)
      }

      TextEditor(text: $viewModel.model.message)
        .font(.body)
        .foregroundStyle(Color("101010"))
        .scrollContentBackground(.hidden)
        .frame(minHeight: 32)
    }
  }
}

struct NewNoteView_Previews: PreviewProvider {
  static var previews: some View {
    NewNoteView(viewModel: .init(createCompletion: {_ in }))
  }
}
