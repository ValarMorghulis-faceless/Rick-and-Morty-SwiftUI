//
//  CharacterListUseCases.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

struct GetCharacterList: GetCharacterListUseCase {
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies = Dependencies()) {
        self.dependencies = dependencies
    }
    
    func retrieve(requestType: GetCharacterListType) async -> Result<CharacterListInfo, GetCharacterListError> {
        let repositoryResult: CharacterListResult
        switch requestType {
        case .homePage:
            repositoryResult = await dependencies.repository.retrieve()
            print(repositoryResult)
        case let .url(url):
            repositoryResult = await dependencies.repository.retrieve(url: url)
        }
        switch repositoryResult {
        case let .success(list):
            return .success(dependencies.mapper.map(response: list))
        case let .failure(error):
            return .failure(dependencies.mapper.map(error: error))
        }
    }
}

extension GetCharacterList {
    struct Dependencies {
        let repository: CharacterListRepository
        let mapper: CharacterListInfoMapper
        init(repository: CharacterListRepository = DefaultCharacterListRepository(), mapper: CharacterListInfoMapper = DefaultCharacterListInfoMapper()) {
            self.repository = repository
            self.mapper = mapper
        }
    }
}


protocol CharacterListInfoMapper {
    func map(response: CharacterList) -> CharacterListInfo
    func map(error: CharacterListRepositoryError) -> GetCharacterListError
}

struct DefaultCharacterListInfoMapper: CharacterListInfoMapper {
    func map(response: CharacterList) -> CharacterListInfo {
        CharacterListInfo(
            characters: response.elements,
            nextPageRequest: response.info.paginationURL.map(GetCharacterListType.url)
        )
    }

    func map(error _: CharacterListRepositoryError) -> GetCharacterListError {
        .unableToGetList
    }
}
