//
//  EpisodeDetailPresenter.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

struct EpisodeDetailPresenter {
    let name: String
    let sections: [EpisodeSection]
    let characters: CharacterPresenter
}

extension EpisodeDetailPresenter {
    struct EpisodeSection: Hashable {
        let title: String
        let rows: [InfoRow]
    }
}

extension EpisodeDetailPresenter {
    struct InfoRow: Hashable {
        let emojiIcon: String
        let title: String
        let value: String
    }
}

extension EpisodeDetailPresenter {
    enum CharacterPresenter: Hashable {
        case data([CharacterPresenterData])
        case placeholder(numberOfItems: Int)
        
        var data: [CharacterPresenterData] {
            switch self {
            case let .data(CharacterPresenter):
                return CharacterPresenter
            case let .placeholder(numberOfItems):
                let placeholder = CharacterPresenterData(image: nil, name: "Name Placeholder", model: .mock)
                return Array(repeating: placeholder, count: numberOfItems)
            }
        }
        
        var isPlaceholder: Bool {
            switch self {
            case .data:
                return false
            case .placeholder:
                return true
            }
        }
        
    }
    struct CharacterPresenterData: Identifiable, Hashable {
        let id = UUID()
        let image: URL?
        let name: String
        let model: CharacterModel
    }
}
