//
//  RemoteEpisodeListDataSource.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation

struct RemoteEpisodeListDataSource: EpisodeListDataSource {
  
    
    private let requester: NetworkRequester
    
    init(requester: NetworkRequester = NetworkRequesterFactory.default) {
        self.requester = requester
    }
    
    func retrieve() async -> EpisodeListDataResult {
        do {
            let data = try await requester.request(targetType: EpisodeListNetworkTargetType.all)
            return mapResponse(from: data)
        } catch {
            return .failure(.custom(error))
        }
    }
    
    func retrieve(url: URL) async -> EpisodeListDataResult {
        do {
            let data = try await requester.request(targetType: URLNetworkTargetType(url: url))
            return mapResponse(from: data)
        } catch {
            return .failure(.custom(error))
        }
    }
    
    func retrieve(search: String) async -> EpisodeListDataResult {
        do {
            let data = try await requester.request(targetType: EpisodeListNetworkTargetType.search(search))
            return mapResponse(from: data)
        } catch {
            return .failure(.custom(error))
        }
    }
}

extension RemoteEpisodeListDataSource {
    func mapResponse(from data: Data) -> EpisodeListDataResult {
        let decoder = JSONDecoder()
        if let response = try? decoder.decode(EpisodeListResponse.self, from: data) {
            return .success(response)
        } else if let response = try? decoder.decode([EpisodeListResponse.EpisodeResult].self, from: data) {
            let emptyInfo = EpisodeListResponse.Info(count: response.count, pages: 1, next: nil, prev: nil)
            return .success(EpisodeListResponse(info: emptyInfo, results: response))
        } else if let response = try? decoder.decode(EpisodeListResponse.EpisodeResult.self, from: data) {
            let emptyInfo = EpisodeListResponse.Info(count: 1, pages: 1, next: nil, prev: nil)
            return .success(EpisodeListResponse(info: emptyInfo, results: [response]))
        } else {
            return .failure(EpisodeListDataSourceError.unableToDecode)
        }
    }
}
