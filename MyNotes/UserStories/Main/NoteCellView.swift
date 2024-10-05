//
//  NoteCellView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 26.12.2022.
//

import SwiftUI

struct NoteCellView: View {
  @EnvironmentObject private var appSettings: AppSettings
  @State var note: NoteModel

  var body: some View {
    contentView
      .padding()
      .background(appSettings.appTheme.noteBackgroundColor)
      .cornerRadius(12)
      .frame(maxHeight: 278)
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
    let date = Text(
      note.date.formatted(
        Date.FormatStyle()
          .day(.twoDigits)
      ) + " "
    )
      .font(.system(size: 48, weight: .semibold))
    let month = Text(
      note.date.formatted(
        Date.FormatStyle()
          .month(.wide)
      )
    )
      .font(.system(size: 24, weight: .semibold))
    ZStack(alignment: .bottomLeading) {
      Rectangle()
        .frame(width: 58, height: 16)
        .foregroundColor(appSettings.appTheme.noteDateRectangleColor)
        .padding(.bottom, 4)
      (date + month)
        .foregroundColor(appSettings.appTheme.noteDateColor)
    }
  }

  @ViewBuilder private var moodView: some View {
    Text(note.mood.rawValue)
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
    Text(!note.title.isEmpty ? note.title : note.message)
      .font(.title)
      .foregroundColor(appSettings.appTheme.noteTitleColor)
  }

  @ViewBuilder private var messageView: some View {
    if !note.title.isEmpty {
      Text(note.message)
        .font(.subheadline)
        .foregroundColor(appSettings.appTheme.noteMessageColor)
    } else {
      EmptyView()
    }
  }
}

struct NoteView_Previews: PreviewProvider {
  static var previews: some View {
    NoteCellView(note: .getDefault())
  }
}
