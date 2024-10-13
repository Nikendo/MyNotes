//
//  NoteViewState.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 10.04.2024.
//

import Foundation

extension NoteScreenViewModel {
  enum ViewState: Equatable {
    case preview
    case new(filled: Bool)
    case edit(filled: Bool)
  }
}
