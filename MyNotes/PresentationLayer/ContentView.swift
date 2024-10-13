//
//  ContentView.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 25.12.2022.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @EnvironmentObject private var appSettings: AppSettings
  @State private var navigationPath: NavigationPath = NavigationPath()
  @State private var repository: NoteRepository
  
  init(repository: NoteRepository) {
    self.repository = repository
  }
  
  var body: some View {
    NoteListScreenBuilder(repository: repository, navigationPath: navigationPath).build()
  }
}

#Preview {
  ContentView(repository: NoteRepositoryImpl(modelContext: ModelContext(previewContainer)))
    .environmentObject(AppSettings())
}
