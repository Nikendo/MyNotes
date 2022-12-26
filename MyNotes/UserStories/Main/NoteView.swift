//
//  NoteView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 26.12.2022.
//

import SwiftUI

struct NoteView: View {

    @State var note: NoteModel

    var body: some View {
        contentView
            .padding()
            .background(Color.cyan)
            .cornerRadius(8)
    }

    @ViewBuilder private var contentView: some View {
        VStack(spacing: 8) {
            topSection
            bottomSection
        }
    }

    @ViewBuilder private var topSection: some View {
        HStack {
            dateView
            Spacer()
            moodView
        }
    }

    @ViewBuilder private var dateView: some View {
        Text(
            note.date.formatted(
                Date.FormatStyle()
                    .day()
            )
            + " " +
            note.date.formatted(
                Date.FormatStyle()
                    .month(.wide)
            )
        )
            .font(.title)
    }

    @ViewBuilder private var moodView: some View {
        Image(systemName: "face.smiling.inverse")
    }

    @ViewBuilder private var bottomSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            titleView
            messageView
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .leading
        )
    }

    @ViewBuilder private var titleView: some View {
        Text(note.title)
            .font(.title)
    }

    @ViewBuilder private var messageView: some View {
        Text(note.message)
            .font(.subheadline)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: .getDefault())
    }
}
