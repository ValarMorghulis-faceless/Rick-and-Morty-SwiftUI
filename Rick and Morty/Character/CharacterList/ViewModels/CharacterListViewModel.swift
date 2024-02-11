//
//  CharacterListViewModel.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import Foundation
//import struct SwiftUI.Binding
//import struct SwiftUI.AnyView
import SwiftUI

protocol CharacterListViewModelInput {
    func showFilters(isPresented: Binding<Bool>) -> AnyView
    func showCharacter(_ character: CharacterModel) -> AnyView
    func scrollViewIsNearBottom()
    func onAppear()
}


protocol CharacterListViewModelOutput {
    var state: ListViewState { get }
    var areFiltersSelected: Bool { get }
    var scrollToCharacterId: UUID? { get }
}

protocol CharacterListViewModelType: ObservableObject {
    var input: CharacterListViewModelInput { get }
    var output: CharacterListViewModelOutput { get }
}

enum ListViewState {
    case display(characterList: CharacterListPresentation)
    case showError(_ error: CharacterListError)
    
    var characterList: CharacterListPresentation {
        switch self {
        case let .display(characterList):
            return characterList
        case .showError:
            return .data(characters: [], hasMore: false)
        }
    }
    
    fileprivate var isPlaceholderShown: Bool {
        switch self {
        case let .display(characterList):
            return characterList.isPlaceholder
        case .showError:
            return false
        }
    }
}

final class CharacterListViewModel: CharacterListViewModelOutput, CharacterListViewModelInput {
    
    func showFilters(isPresented: Binding<Bool>) -> AnyView {
        return AnyView(Text("Fuck youuuuu"))
    }
    
 
    
    func scrollViewIsNearBottom() {
        
    }
    
    func onAppear() {
        retrieveCharacters()
    }
    
    @Published private(set) var state: ListViewState = .display(characterList: .placeholder(numberOfItems: 0))
    @Published private(set) var areFiltersSelected: Bool = false
    @Published private(set) var scrollToCharacterId: UUID?
    private var nextPageRequest: GetCharacterListType?
    private let coordinator: CharacterListCoordinator
   // private var selectedFilters = Filters.default
    private let dependencies: Dependencies
    
    init(coordinator: CharacterListCoordinator ,dependencies: Dependencies = Dependencies()){
        self.dependencies = dependencies
        self.coordinator = coordinator
    }
    
    func retrieveCharacters() {
        let characterListInfo = CharacterListInfo(characters: mockCharacterList, nextPageRequest: .homePage)
        let characterList = dependencies.characterListViewMapper.map(from: characterListInfo)
        let currentCharacters = state.characterList.data
        let characters = currentCharacters + characterList.data
        let presentation = CharacterListPresentation.data(characters: characters, hasMore: characterList.hasMore)
        self.state = .display(characterList: presentation)
    }
    
    func showCharacter(_ character: CharacterModel) -> AnyView {
        coordinator.showCharacter(character)
    }
    
}

extension CharacterListViewModel: CharacterListViewModelType {
    var input: CharacterListViewModelInput { self }
    var output: CharacterListViewModelOutput { self }
}

 //MARK: - Dependencies

extension CharacterListViewModel {
    struct Dependencies {
    //    let getCharacterList: GetCharacterListUseCase
        let characterListViewMapper: CharacterListViewMapper
        init(characterListViewMapper: CharacterListViewMapper = DefaultCharacterListViewMapper()) {
            self.characterListViewMapper = characterListViewMapper
        }
    }
    
}
