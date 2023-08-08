//
//  MyNotesApp.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 25.12.2022.
//

import SwiftUI
import SwiftData

@main
struct MyNotesApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .preferredColorScheme(.light)
    }
    .modelContainer(for: NoteModel.self)
  }
}
