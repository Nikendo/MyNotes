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
  @StateObject var appSettings = AppSettings()
  private let repository: NoteRepository = {
    do {
      let modelContainer = try ModelContainer(for: NoteData.self)
      return NoteRepositoryImpl(modelContext: ModelContext(modelContainer))
    } catch {
      fatalError(error.localizedDescription)
    }
  }()
  
  var body: some Scene {
    WindowGroup {
      ContentView(repository: repository)
        .preferredColorScheme(.light)
        .tint(appSettings.appTheme.noteMessageColor)
    }
    .environmentObject(appSettings)
  }
}
