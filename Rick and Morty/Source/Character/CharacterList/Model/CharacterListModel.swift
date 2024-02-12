//
//  CharacterListModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import Foundation

//MARK: - Character

struct CharacterListResponse: Decodable {
    let info: Info
    let results: [ListResult]
}

extension CharacterListResponse {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}

//MARK: - List Result

extension CharacterListResponse {
    struct ListResult: Decodable {
        let id: Int
        let name: String
        let status: Status
        let species: String
        let type: String
        let gender: Gender
        let origin: Location
        let location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
    }
}


// MARK: - Gender

extension CharacterListResponse.ListResult {
    enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown
    }
}

// MARK: - Location

extension CharacterListResponse.ListResult {
    struct Location: Decodable {
        let name: String
        let url: String
    }
}

// MARK: - Status

extension CharacterListResponse.ListResult {
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
}
