//
//  RemoteCharacterListDataSource.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation

public enum NetworkRequesterFactory {
    public static let `default`: NetworkRequester = DefaultNetworkRequester()
}

struct RemoteCharacterListDataSource: CharacterListDataSource {
    private let requester: NetworkRequester
    
    init(requester: NetworkRequester = NetworkRequesterFactory.default) {
        self.requester = requester
    }
    func retrieve() async -> CharacterListDataResult {
        do {
            let data = try await requester.request(targetType: CharacterListEndpoint.all)
            return mapResponse(from: data)
        } catch {
            return .failure(.custom(error))
        }
    }
    func retrieve(url: URL) async -> CharacterListDataResult{
        do {
            let data = try await requester.request(targetType: URLNetworkTargetType(url: url))
            return mapResponse(from: data)
        } catch {
            return .failure(.custom(error))
        }
    }
    
    func retrieve(search: String) async -> CharacterListDataResult {
        do {
            let data = try await requester.request(targetType: CharacterListEndpoint.search(search))
            return mapResponse(from: data)
        } catch {
            return .failure(.custom(error))
        }
    }
}

extension RemoteCharacterListDataSource {
    func mapResponse(from data: Data) -> CharacterListDataResult {
        print(data)
        let decoder = JSONDecoder()
        if let response = try? decoder.decode(CharacterListResponse.self, from: data) {
            return .success(response)
        } else if let response = try? decoder.decode([CharacterListResponse.ListResult].self, from: data) {
            let emptyInfo = CharacterListResponse.Info(count: response.count, pages: 1, next: nil, prev: nil)
            return .success(CharacterListResponse(info: emptyInfo, results: response))
        } else if let response = try? decoder.decode(CharacterListResponse.ListResult.self, from: data) {
            let emptyInfo = CharacterListResponse.Info(count: 1, pages: 1, next: nil, prev: nil)
            return .success(CharacterListResponse(info: emptyInfo, results: [response]))
        } else {
            return .failure(CharacterListDataSourceError.unableToDecode)
        }
    }
}
