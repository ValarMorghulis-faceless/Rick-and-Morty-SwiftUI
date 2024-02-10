//
//  CharacterListInfo.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import Foundation

public struct CharacterListInfo {
    public let characters: [CharacterModel]
    public let nextPageRequest: GetCharacterListType?
    
    public init(characters: [CharacterModel], nextPageRequest: GetCharacterListType?) {
        self.characters = characters
        self.nextPageRequest = nextPageRequest
    }
    
}

public extension CharacterListInfo {
    var areMoreAvaliable: Bool {
        nextPageRequest != nil
    }
}

public enum GetCharacterListError: Error {
    case unableToGetList
}

public enum GetCharacterListType: Equatable {
    case homePage
   // case filtered(Filters)
   // case url(URL)
}

public protocol GetCharacterListUseCase {
    func retrieve(requestType: GetCharacterListType) async -> Result<CharacterListInfo, GetCharacterListError>
}
