//
//  EpisodeListPresenter.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

struct EpisodePresenter: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let airDate: String
    let model: EpisodeModel
}

enum EpisodeListPresenter {
    case data(episodes: [EpisodePresenter], hasMore: Bool)
    case placeholder(numberOfItems: Int)
    
    var data: [EpisodePresenter] {
        switch self {
        case let .data(episodes, _):
            return episodes
        case let .placeholder(numberOfItems):
            let episodes = [Int](0 ..< numberOfItems).map { _ in
                EpisodePresenter(title: "Title placeholder", airDate: "Air date placeholder", model: .mock)
            }
            return episodes
        }
    }
    var hasMore: Bool {
        switch self {
        case let .data(_, hasMore):
            return hasMore
        case .placeholder:
            return false
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

struct EpisodeListError {
    let title: String
    let description: String
}
