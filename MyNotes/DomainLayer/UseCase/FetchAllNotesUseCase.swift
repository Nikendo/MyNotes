//
//  FetchAllNotesUseCase.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 11.10.2024.
//

protocol FetchAllNotesUseCase: AnyObject {
  func execute() async throws -> [Note]
}
