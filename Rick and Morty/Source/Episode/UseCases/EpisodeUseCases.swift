//
//  EpisodeUseCases.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

public enum GetEpisodeListError: Error {
    case unableToGetList
}

public enum GetEpisodeListType {
    case homePage
    case url(URL)
}

public protocol GetEpisodeListUseCase {
    func retrieve(requestType: GetEpisodeListType) async -> Result<EpisodeListInfo, GetEpisodeListError>
}

struct GetEpisodeList: GetEpisodeListUseCase {
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies = Dependencies()) {
        self.dependencies = dependencies
    }
    
    func retrieve(requestType: GetEpisodeListType) async -> Result<EpisodeListInfo, GetEpisodeListError> {
        let repositoryResult: EpisodeListResult
        switch requestType {
        case .homePage:
            repositoryResult = await dependencies.repository.retrieve()
        case let .url(url):
            repositoryResult = await dependencies.repository.retrieve(url: url)
        }
        switch repositoryResult {
        case let .success(list):
            return .success(dependencies.mapper.map(response: list))
        case let .failure(error):
            return .failure(dependencies.mapper.map(erro: error))
        }
    }
    
}

extension GetEpisodeList {
    struct Dependencies {
        let repository: EpisodeListRepository
        let mapper: EpisodeListInfoMapper
        init(repository: EpisodeListRepository = DefaultEpisodeListRepository(), mapper: EpisodeListInfoMapper = DefaultEpisodeListInfoMapper()) {
            self.repository = repository
            self.mapper = mapper
        }
    }
}
