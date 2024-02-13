//
//  DefaultCharacterListRepository.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

struct DefaultCharacterListRepository: CharacterListRepository {
    private let dependencies: Dependencies

    init(dependencies: Dependencies = Dependencies()) {
        self.dependencies = dependencies
    }

    func retrieve() async -> CharacterListResult {
        let remoteDataSourceResult = await dependencies.remoteDataSource.retrieve()
        print(remoteDataSourceResult)
        return mapResponse(from: remoteDataSourceResult)
    }

    func retrieve(url: URL) async -> CharacterListResult {
        let remoteDataSourceResult = await dependencies.remoteDataSource.retrieve(url: url)
        return mapResponse(from: remoteDataSourceResult)
    }
    
    func retrieve(search: String) async -> CharacterListResult {
        let remoteDataSourceResult = await dependencies.remoteDataSource.retrieve(search: search)
        return mapResponse(from: remoteDataSourceResult)
    }


}

private extension DefaultCharacterListRepository {
    func mapResponse(from result: CharacterListDataResult) -> CharacterListResult {
        switch result {
        case let .success(response):
            return .success(dependencies.mapper.map(response: response))
        case let .failure(error):
            return .failure(dependencies.mapper.map(error: error))
        }
    }
}

// MARK: - Dependencies

extension DefaultCharacterListRepository {
    struct Dependencies {
        let remoteDataSource: CharacterListDataSource
        let mapper: CharacterListMapper

        init(
            remoteDataSource: CharacterListDataSource = RemoteCharacterListDataSource(),
            mapper: CharacterListMapper = DefaultCharacterListMapper()
        ) {
            self.remoteDataSource = remoteDataSource
            self.mapper = mapper
        }
    }
}

// MARK: - CharacterListRequestParameters+Filters

//private extension CharacterListRequestParameters {
//    init(filters: Filters) {
//        self.status = filters.status?.rawValue
//        self.gender = filters.gender?.rawValue
//    }
//}
