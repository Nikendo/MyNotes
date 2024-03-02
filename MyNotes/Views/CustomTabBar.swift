//
//  CustomTabBar.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 26.12.2022.
//

import SwiftUI

struct CustomTabBar: View {
  @EnvironmentObject private var appSettings: AppSettings
  @State private var isPresentNewNote = false
  var createNewNoteCompletion: (NoteModel) -> Void
  
  var body: some View {
    HStack {
//      calendarView
      Spacer()
      newView
      Spacer()
//      profileView
    }
    .padding(.horizontal, 44)
    .padding(.vertical, 16)
    .foregroundColor(.white)
    .background(Color.clear)
  }
  
  @ViewBuilder private var calendarView: some View {
    NavigationLink(
      destination: {
        EmptyView()
      },
      label: {
        Image(systemName: "calendar")
          .resizable()
          .frame(width: 18, height: 18)
          .padding(12)
          .background(Color.blue)
          .cornerRadius(28)
      }
    )
  }
  
  @ViewBuilder private var newView: some View {
    Button(
      action: {
        isPresentNewNote.toggle()
      }, label: {
        Image(systemName: "plus")
          .resizable()
          .frame(width: 24, height: 24)
          .padding()
          .background(appSettings.appTheme.newNoteButtonBackgroundColor)
          .foregroundStyle(appSettings.appTheme.newNoteButtonTintColor)
          .cornerRadius(28)
      }
    )
    .fullScreenCover(
      isPresented: $isPresentNewNote,
      content: {
        NewNoteView(viewModel: .init(createCompletion: createNewNoteCompletion))
      }
    )
  }
  
  @ViewBuilder private var profileView: some View {
    NavigationLink(
      destination: {
        EmptyView()
      },
      label: {
        Image(systemName: "person.crop.circle")
          .resizable()
          .frame(width: 18, height: 18)
          .padding(12)
          .background(Color.blue)
          .cornerRadius(28)
      }
    )
  }
}

struct CustomTabBar_Previews: PreviewProvider {
  static var previews: some View {
    CustomTabBar(createNewNoteCompletion: {_ in })
  }
}
