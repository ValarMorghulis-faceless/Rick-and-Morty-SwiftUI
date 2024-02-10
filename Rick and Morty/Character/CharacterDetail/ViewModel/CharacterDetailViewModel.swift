//
//  CharacterDetailViewModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import Foundation

protocol CharacterDetailViewModelOutput {
    var state: ViewState { get }
}

protocol CharacterDetailViewModelType: ObservableObject {
    var output: CharacterDetailViewModelOutput { get }
}

typealias ViewState = CharacterDetailPresenter

final class CharacterDetailViewModel: CharacterDetailViewModelOutput {
    @Published private(set) var state: ViewState
    private let character: CharacterModel
    private let dependencies: Dependencies
    
    init(character: CharacterModel, dependencies: Dependencies){
        self.character = character
        self.dependencies =  dependencies
        state = dependencies.characterDetailViewMapper.map(from: character)
    }
    
}

extension CharacterDetailViewModel: CharacterDetailViewModelType {
    var output: CharacterDetailViewModelOutput { self }
}


extension CharacterDetailViewModel {
    struct Dependencies {
        let characterDetailViewMapper: CharacterDetailViewMapper
        init(characterDetailViewMapper: CharacterDetailViewMapper = DefaultCharacterDetailViewMapper()) {
            self.characterDetailViewMapper = characterDetailViewMapper
        }
    }
}
