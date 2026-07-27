//
//  MapperTests.swift
//  MyNotesTests
//
//  Created by Shmatov Nikita on 18.07.2025.
//

import XCTest
@testable import MyNotes

final class MapperTests: XCTestCase {

    func testNoteToNoteDataPositive() throws {
        let note = Note(id: UUID(), date: Date.now, mood: .happy, title: "Test", message: "Test Description")
        let noteData = NoteData(from: note)
        let noteFromNoteData = Note(from: noteData)

        XCTAssertEqual(note, noteFromNoteData, "Retrieved note is not equeal to origin note.")
    }

    func testNoteToNoteDataNegative() throws {
        let note = Note(id: UUID(), date: Date.now, mood: .happy, title: "Test", message: "Test Description")
        let noteData = NoteData(from: note)
        let noteFromNoteData = Note(from: noteData)
        let toCheck = Note(id: noteFromNoteData.id, date: noteFromNoteData.date, mood: .normal, title: noteFromNoteData.title, message: noteFromNoteData.message)

        XCTAssertNotEqual(note, toCheck, "Retrieved note should be not queal to origin note as it has been modified.")
    }
}
