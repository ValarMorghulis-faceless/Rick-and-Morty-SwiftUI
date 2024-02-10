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
