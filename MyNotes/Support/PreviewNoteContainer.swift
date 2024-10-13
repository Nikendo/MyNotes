//
//  PreviewNoteContainer.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 08.08.2023.
//

import SwiftUI
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
  do {
    let container = try ModelContainer(for: NoteData.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    for _ in 0..<5 {
      container.mainContext.insert(NoteData(
        id: UUID(),
        date: .now,
        mood: .normal,
        title: "Title",
        message: "Description"
      ))
    }
    return container
  } catch {
    fatalError("Failed to create container")
  }
}()
