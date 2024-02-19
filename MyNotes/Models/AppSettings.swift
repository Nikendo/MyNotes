//
//  AppSettings.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 19.02.2024.
//

import Foundation
import Combine

final class AppSettings: ObservableObject {
  @Published var notesOrder: NotesOrder
  private var cancellables: Set<AnyCancellable> = []

  init() {
    notesOrder = NotesOrder(rawValue: UserDefaults.standard.integer(forKey: "notes_order")) ?? .reversed
    setupBindings()
  }

  private func setupBindings() {
    $notesOrder.sink { order in
      UserDefaults.standard.set(order.rawValue, forKey: "notes_order")
    }
    .store(in: &cancellables)
  }

  enum NotesOrder: Int, CaseIterable {
    case reversed, forwarded
  }
}
