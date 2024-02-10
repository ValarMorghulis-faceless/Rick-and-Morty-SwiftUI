//
//  CharacterModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import Foundation


public struct CharacterModel: Hashable{
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String?
    let gender: Gender
    let origin: Location
    let location: Location
    let image: URL
    let episode: [String]
    let url: String
    let created: String
    let numberOfEpisodes: Int
    
    init(id: Int, name: String, status: Status, species: String, type: String, gender: Gender, origin: Location, location: Location, image: URL, episode: [String], url: String, created: String, numberOfEpisodes: Int) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
        self.numberOfEpisodes = numberOfEpisodes
    }
}

public extension CharacterModel {
    enum Status: String, Hashable, CaseIterable {
        case alive, dead, unknown
    }
}

// MARK: - Status

public extension CharacterModel {
    enum Gender: String, Hashable, CaseIterable {
        case female, male, genderless, unknown
    }
}

// MARK: - Location

public extension CharacterModel {
    enum Location: Hashable {
        case known(name: String, url: URL)
        case unknown
    }
}

public extension CharacterModel {
    static let mock = CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        type: "",
        gender: .male,
        origin: .known(name: "Eart", url: .mockOriginURL),
        location: .known(name: "Eart", url: .mockLocationUrl),
        image: .mockimageurl,
        episode: ["https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1",
                  "https://rickandmortyapi.com/api/episode/1"],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 6)
}



public let mockCharacterList: [CharacterModel] = [
        CharacterModel(
            id: 1,
            name: "Rick Sanchez",
            status: .dead,
            species: "Human",
            type: "",
            gender: .female,
            origin: .known(name: "Earth", url: .mockOriginURL),
            location: .known(name: "Earth", url: .mockLocationUrl),
            image: .mockimageurl,
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 63
        ),
        CharacterModel(
            id: 2,
            name: "Morty Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .known(name: "Earth", url: .mockOriginURL),
            location: .known(name: "Earth", url: .mockLocationUrl),
            image: .mockimageurl,
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1"
            ],
            url: "https://rickandmortyapi.com/api/character/2",
            created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 231
        ),
        CharacterModel(
            id: 3,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .known(name: "Earth", url: .mockOriginURL),
            location: .known(name: "Earth", url: .mockLocationUrl),
            image: .mockimageurl,
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 123
        ),
        CharacterModel(
            id: 4,
            name: "Morty Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .known(name: "Earth", url: .mockOriginURL),
            location: .known(name: "Earth", url: .mockLocationUrl),
            image: .mockimageurl,
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1"
            ],
            url: "https://rickandmortyapi.com/api/character/2",
            created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 11
        ),
        CharacterModel(
            id: 5,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .known(name: "Earth", url: .mockOriginURL),
            location: .known(name: "Earth", url: .mockLocationUrl),
            image: .mockimageurl,
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 11
        ),
        CharacterModel(
            id: 6,
            name: "Morty Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .known(name: "Earth", url: .mockOriginURL),
            location: .known(name: "Earth", url: .mockLocationUrl),
            image: .mockimageurl,
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1"
            ],
            url: "https://rickandmortyapi.com/api/character/2",
            created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 33
        ),
        CharacterModel(
            id: 7,
            name: "Rick Sanchez",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .known(name: "Earth", url: .mockOriginURL),
            location: .known(name: "Earth", url: .mockLocationUrl),
            image: .mockimageurl,
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 44
        ),
        CharacterModel(
            id: 8,
            name: "Morty Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .known(name: "Earth", url: .mockOriginURL),
            location: .known(name: "Earth", url: .mockLocationUrl),
            image: .mockimageurl,
            episode: [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/1"
            ],
            url: "https://rickandmortyapi.com/api/character/2",
            created: "2017-11-04T18:48:46.250Z", numberOfEpisodes: 11
        ),
    

]
