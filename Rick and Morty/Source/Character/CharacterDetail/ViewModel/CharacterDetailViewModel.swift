//
//  CharacterDetailViewModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import SwiftUI

protocol CharacterDetailViewModelInput {
    func onAppear()
    func showEpisode(_ episode: EpisodeModel) -> AnyView
}

protocol CharacterDetailViewModelOutput {
    var state: ViewState { get }
}

protocol CharacterDetailViewModelType: ObservableObject {
    var input: CharacterDetailViewModelInput { get }
    var output: CharacterDetailViewModelOutput { get }
}

typealias ViewState = CharacterDetailPresenter

public final class CharacterDetailViewModel: CharacterDetailViewModelOutput {
    @Published private(set) var state: ViewState
    private let character: CharacterModel
    private let coordinator: CharacterDetailCoordinatorProtocol
    private let dependencies: Dependencies
    
    init(coordinator: CharacterDetailCoordinatorProtocol, character: CharacterModel, dependencies: Dependencies){
        self.character = character
        self.coordinator = coordinator
        self.dependencies =  dependencies
        state = dependencies.characterDetailViewMapper.map(from: character)
    }
    
    private func retrieveCharacterEpisodes() {
        Task { @MainActor in
            let episodeListResult = await dependencies.getEpisodeList.retrieve(requestType: .url(character.episodesUrl))
            
            guard let listInfo = try? episodeListResult.get() else { return }
            
            state = dependencies.characterDetailViewMapper.map(from: listInfo, for: state)
            
        }
    }
    
}

extension CharacterDetailViewModel: CharacterDetailViewModelType {
    var input: CharacterDetailViewModelInput { self }
    var output: CharacterDetailViewModelOutput { self }
}

extension CharacterDetailViewModel: CharacterDetailViewModelInput {
    func onAppear() {
        guard state.episodes.isPlaceholder else { return }
        retrieveCharacterEpisodes()
    }
    
    func showEpisode(_ episode: EpisodeModel) -> AnyView {
        coordinator.showEpisode(episode)
    }
}

extension CharacterDetailViewModel {
    struct Dependencies {
        let getEpisodeList: GetEpisodeListUseCase
        let characterDetailViewMapper: CharacterDetailViewMapper
        init(getEpisodeList: GetEpisodeListUseCase, characterDetailViewMapper: CharacterDetailViewMapper = DefaultCharacterDetailViewMapper()) {
            self.getEpisodeList = getEpisodeList
            self.characterDetailViewMapper = characterDetailViewMapper
        }
    }
}
