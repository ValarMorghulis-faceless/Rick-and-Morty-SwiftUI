//
//  EpisodeListViewModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import Foundation
import SwiftUI


protocol EpisodeListViewModelInput {
    func onAppear()
    func showEpisode(_ episode: EpisodeModel) -> AnyView
    func scrollViewIsNearBottom()
}

protocol EpisodeListViewModelOutput {
    var state: EpisodeListViewState { get }
}

protocol EpisodeListViewModelType: ObservableObject {
    var input: EpisodeListViewModelInput { get }
    var output: EpisodeListViewModelOutput { get }
}

enum EpisodeListViewState {
    case display(episodeList: EpisodeListPresenter)
    case showError(_ error: EpisodeListError)
    
    var episodeList: EpisodeListPresenter {
        switch self {
        case let .display(episodeList):
            return episodeList
        case .showError:
            return .data(episodes: [], hasMore: false)
        }
    }
    var isPlaceholderShown: Bool {
        switch self {
        case let .display(episodeList):
            return episodeList.isPlaceholder
        case .showError:
            return false
        }
    }
}


final class EpisodeListViewModel: EpisodeListViewModelOutput {
    @Published private(set) var state: EpisodeListViewState = .display(episodeList: .placeholder(numberOfItems: 20))
    private var nextPageRequest: GetEpisodeListType?
  //  private let navigator: EpisodeListWireframe
    private let dependencies: Dependencies
    init(dependencies: Dependencies = Dependencies()) {
        self.dependencies = dependencies
    }
    
    private func retrieveEpisodes(requestType: GetEpisodeListType, shouldReload: Bool) {
        Task { @MainActor in
            let episodeListResult = await dependencies.getEpisodeList.retrieve(requestType: requestType)
            
            switch episodeListResult {
            case let .success(listInfo):
                let episodeList = self.dependencies.episodeListViewMapper.map(from: listInfo, shouldReload: shouldReload)
                let currentEpisodes = shouldReload ? [] : self.state.episodeList.data
                let episodes = currentEpisodes + episodeList.data
                let presentation = EpisodeListPresenter.data(episodes: episodes, hasMore: episodeList.hasMore)
                self.nextPageRequest = listInfo.nextPageRequest
                self.state = .display(episodeList: presentation)
                
            case let .failure(error):
                processRetrieveEpisodesError(error, shouldReload: shouldReload)
            }
            
        }
    }
    
    private func processRetrieveEpisodesError(_ error: GetEpisodeListError, shouldReload: Bool) {
        guard shouldReload else { return }
        let errorState = dependencies.episodeListViewMapper.map(from: error)
        state = .showError(errorState)
    }
    
}

extension EpisodeListViewModel {
    struct Dependencies {
        let getEpisodeList: GetEpisodeListUseCase
        let episodeListViewMapper: EpisodeListViewMapper
        init(getEpisodeList: GetEpisodeListUseCase = GetEpisodeList(), episodeListViewMapper: EpisodeListViewMapper = DefaultEpisodeListViewMapper()) {
            self.getEpisodeList = getEpisodeList
            self.episodeListViewMapper = episodeListViewMapper
        }
    }
}
