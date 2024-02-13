//
//  EpisodeDetailViewModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 12.02.24.
//

import SwiftUI

protocol EpisodeDetailViewModelInput {
    func onAppear()
    func showCharacter(_ character: CharacterModel) -> AnyView
}

protocol EpisodeDetailViewModelOutput {
    var state: EpisodeViewState { get }
}

protocol EpisodeDetailViewModelType: ObservableObject {
    var input: EpisodeDetailViewModelInput { get }
    var output: EpisodeDetailViewModelOutput { get }
}

typealias EpisodeViewState = EpisodeDetailPresenter

final class EpisodeDetailViewModel: EpisodeDetailViewModelOutput {
    @Published private(set) var state: EpisodeViewState
    private let episode: EpisodeModel
    private let coordinator: EpisodeDetailCoordinatorProtocol
    private let dependencies: Dependencies
    
    init(episode: EpisodeModel, coordinator: EpisodeDetailCoordinatorProtocol, dependencies: Dependencies) {
        self.episode = episode
        self.coordinator = coordinator
        self.dependencies = dependencies
        state = dependencies.episodeDetailViewMapper.map(from: episode)
    }
    
    private func retrieveEpisodeCharacters() {
        Task { @MainActor in
            let characterListResult = await dependencies.getCharacterList.retrieve(requestType: .url(episode.characterListUrl))
            
            guard let listInfo = try? characterListResult.get() else {
                return
            }
            
            state = dependencies.episodeDetailViewMapper.map(from: listInfo, for: state)
            
        }
    }
}

extension EpisodeDetailViewModel: EpisodeDetailViewModelType {
    var input: EpisodeDetailViewModelInput { self }
    
    var output: EpisodeDetailViewModelOutput { self }
}

extension EpisodeDetailViewModel: EpisodeDetailViewModelInput {
    func onAppear() {
        guard state.characters.isPlaceholder else { return }
        retrieveEpisodeCharacters()
    }
    
    func showCharacter(_ character: CharacterModel) -> AnyView {
        coordinator.showCharacter(character)
    }
}

extension EpisodeDetailViewModel {
    struct Dependencies {
        let getCharacterList: GetCharacterListUseCase
        let episodeDetailViewMapper: EpisodeDetailViewMapper
        
        init(getCharacterList: GetCharacterListUseCase, episodeDetailViewMapper: EpisodeDetailViewMapper = DefaultEpisodeDetailViewMapper()) {
            self.getCharacterList = getCharacterList
            self.episodeDetailViewMapper = episodeDetailViewMapper
        }
        
    }
    
}
