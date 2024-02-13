//
//  CharacterListRepo.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

struct CharactersInfo {
    let paginationURL: URL?
}

struct CharacterList {
    let elements: [CharacterModel]
    let info: CharactersInfo
}

enum CharacterListRepositoryError: Error {
    case unableToDecode
    case dataSource(Error)
}

typealias CharacterListResult = Result<CharacterList, CharacterListRepositoryError>

protocol CharacterListRepository {
    func retrieve() async -> CharacterListResult
    func retrieve(url: URL) async -> CharacterListResult
    func retrieve(search: String) async -> CharacterListResult
}


typealias CharacterListDataResult = Result<CharacterListResponse, CharacterListDataSourceError>

enum CharacterListDataSourceError: Error {
    case unableToDecode
    case custom(Error)
}

protocol CharacterListDataSource {
    func retrieve() async -> CharacterListDataResult
    func retrieve(url: URL) async -> CharacterListDataResult
    func retrieve(search: String) async -> CharacterListDataResult
}
