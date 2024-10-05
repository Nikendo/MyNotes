//
//  SystemIcons.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 08.10.2024.
//


enum SystemIcons: String {
  case close = "xmark"
  case edit = "square.and.pencil"
  case accept = "checkmark"
  case search = "doc.text.magnifyingglass"
  
  var name: RawValue { rawValue }
}
