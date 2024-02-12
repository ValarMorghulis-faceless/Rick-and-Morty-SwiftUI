//
//  CharacterDetailPresenter.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import Foundation

struct CharacterDetailPresenter: Hashable {
    let image: URL
    let name: String
    let sections: [InfoSection]
    let episodesSectionTitle: String
    let episodes: EpisodePresenter
}

extension CharacterDetailPresenter {
    struct InfoSection: Hashable {
        let title: String
        let rows: [InfoRow]
    }
}

extension CharacterDetailPresenter {
    struct InfoRow: Hashable {
        let emojiIcon: String
        let title: String
        let value: String
        let statusColor: String?
    }
}

extension CharacterDetailPresenter {
    enum EpisodePresenter: Hashable {
        case data ([EpisodePresenterData])
        case placeholder(numberOfItems: Int)
        var data: [EpisodePresenterData] {
            switch self {
            case let .data(episodePresenter):
                return episodePresenter
            case let .placeholder(numberOfItems):
                let placeholder = EpisodePresenterData(title: "Title Placeholder", airDate: "Placeholder", model: .mock)
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
    
    struct EpisodePresenterData: Identifiable, Hashable {
        let id = UUID()
        let title: String
        let airDate: String
        let model: EpisodeModel
    }
}
