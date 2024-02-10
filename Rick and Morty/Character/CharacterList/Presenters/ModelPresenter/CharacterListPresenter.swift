//
//  CharacterListPresenter.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import Foundation

struct CharacterPresenter: Identifiable, Hashable {
    let id = UUID()
    let image: URL?
    let name: String
    let model: CharacterModel
}

enum CharacterListPresentation{
    case data(characters: [CharacterPresenter], hasMore: Bool)
    case placeholder(numberOfItems: Int)
    
    var data: [CharacterPresenter] {
        switch self {
        case let .data(characters, _):
            return characters
        case let .placeholder(numberOfItems):
            let characters = [Int](0 ..< numberOfItems).map { _ in
                CharacterPresenter(image: nil, name: "Name placeholder", model: .mock)
            }
            return characters
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

//MARK: - Error
struct CharachterListError {
    let title: String
    let description: String
}
