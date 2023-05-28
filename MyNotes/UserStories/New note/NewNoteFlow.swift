//
//  NewNoteFlow.swift
//  MyNotes
//
//  Created by Shmatov Nikita on 29.05.2023.
//

import Foundation

extension NewNoteViewModel {
    enum Flow {
        enum ViewState {
            case normal
            case error
        }

        enum Event {
            case save
            case cancel
        }

        enum Destination {
            case none
            case save
            case cancel
        }
    }
}
