//
//  CharacterListViewMapper.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import Foundation

protocol CharacterListViewMapper {
    func map(from listInfo: CharacterListInfo) -> CharacterListPresentation
    func map(from error: GetCharacterListError) -> CharacterListError
}

struct DefaultCharacterListViewMapper: CharacterListViewMapper {
    
    func map(from listInfo: CharacterListInfo) -> CharacterListPresentation {
        let characters = listInfo.characters.map { character in
            CharacterPresenter(image: character.image, name: character.name, model: character)
        }
        return .data(characters: characters, hasMore: listInfo.areMoreAvaliable)
    }
    
    func map(from error: GetCharacterListError) -> CharacterListError {
        switch error {
        case .unableToGetList:
            return CharacterListError(title: "Characters error", description: "There are no characters to show right now.")
        }
    }
    
}
