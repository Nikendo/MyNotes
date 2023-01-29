//
//  NewNoteView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 29.01.2023.
//

import SwiftUI

struct NewNoteView: View {
    @State var note: NoteModel
    @State var selectedDate: Date = .now
    @State var title: String = ""
    @State var message: String = ""

    var body: some View {
        ZStack {
            backgroundView
            contentView
        }
    }

    @ViewBuilder private var backgroundView: some View {
        Color("D9E8FD").ignoresSafeArea()
    }

    @ViewBuilder private var contentView: some View {
        VStack {
            headerView
            subheaderView
            textsView
            Spacer()
        }
    }

    // MARK: - Header

    @ViewBuilder private var headerView: some View {
        HStack(spacing: 0) {
            closeView
            Spacer()
            searchView
            saveView
        }
    }

    @ViewBuilder private var closeView: some View {
        Image(systemName: "xmark")
            .foregroundColor(Color("64696F"))
            .padding()
    }

    @ViewBuilder private var searchView: some View {
        Image(systemName: "doc.text.magnifyingglass")
            .foregroundColor(Color("64696F"))
            .padding()
    }

    @ViewBuilder private var saveView: some View {
        Button(
            action: {
                print("Save")
            },
            label: {
                Text("Save")
            }
        )
        .buttonStyle(RoundedButtonStyle())
        .padding()
    }

    // MARK: - Subheader

    @ViewBuilder private var subheaderView: some View {
        HStack(spacing: 0) {
            datePickerView
            Spacer()
            moodPickerView
        }
    }

    @ViewBuilder private var datePickerView: some View {
        DatePicker(
            selection: $selectedDate,
            displayedComponents: .date,
            label: {
                EmptyView()
            }
        )
        .labelsHidden()
        .padding()
    }

    @ViewBuilder private var moodPickerView: some View {
        ZStack {
            Circle().opacity(0.1)
                .frame(maxWidth: 40)
            Text(note.mood.rawValue)
                .font(.system(size: 20))
        }
            .padding()
    }

    // MARK: - Text

    @ViewBuilder private var textsView: some View {
        VStack {
            titleView
            messageView
                .layoutPriority(2)
        }
        .padding(.horizontal)
    }

    @ViewBuilder private var titleView: some View {
        ZStack(alignment: .leading) {
            if title.isEmpty {
                Text("title")
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundColor(Color("A7B1C0"))
            }

            TextEditor(text: $title)
                .font(.system(size: 36, weight: .semibold))
                .foregroundColor(Color("101010"))
                .scrollContentBackground(.hidden)
                .lineLimit(2)
                .frame(minHeight: 48)
        }
    }

    @ViewBuilder private var messageView: some View {
        ZStack(alignment: .leading) {
            if message.isEmpty {
                VStack {
                    Text("write here...")
                        .font(.system(size: 29, weight: .semibold))
                    .foregroundColor(Color("A7B1C0"))
                    Spacer()
                }
            }

            TextEditor(text: $message)
                .font(.system(size: 29, weight: .semibold))
                .foregroundColor(Color("101010"))
                .scrollContentBackground(.hidden)
                .frame(minHeight: 32)
        }
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView(note: .getDefault())
    }
}
