//
//  CharacterList.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 15.02.24.
//

import Foundation

struct CharactersInfo {
    let paginationURL: URL?
}

struct CharacterList {
    let elements: [CharacterModel]
    let info: CharactersInfo
}
