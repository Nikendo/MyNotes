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
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView(note: .getDefault())
    }
}
