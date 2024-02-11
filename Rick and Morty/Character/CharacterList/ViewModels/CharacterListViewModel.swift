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
        guard let nextPageRequest = nextPageRequest else { return }
        retrieveCharacters(requestType: nextPageRequest, shouldReload: false)
    }
    
    func onAppear() {
        guard state.isPlaceholderShown else { return }
        retrieveCharacters(requestType: .homePage, shouldReload: true)
       // retrieveCharacters()
    }
    
    @Published private(set) var state: ListViewState = .display(characterList: .placeholder(numberOfItems: 20))
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
    
    func retrieveCharacters(requestType: GetCharacterListType, shouldReload: Bool) {
        Task { @MainActor in
            let characterListResult = await dependencies.getCharacterList.retrieve(requestType: requestType)
            switch characterListResult {
            case .success(let listInfo):
                print(listInfo)
                let characterList = dependencies.characterListViewMapper.map(from: listInfo)
                let currentCharacters = shouldReload ? [] : state.characterList.data
                let characters = currentCharacters + characterList.data
                let presentation = CharacterListPresentation.data(characters: characters, hasMore: characterList.hasMore)
                self.nextPageRequest = listInfo.nextPageRequest
                self.state = .display(characterList: presentation)
            //    self.areFiltersSelected = !
                self.scrollToCharacterId = shouldReload ? characters.first?.id : nil
            case .failure(let error):
                print(error)
                processRetrieveCharactersError(error, shouldReload: shouldReload)
            }
            
        }

    }
    
    private func processRetrieveCharactersError(_ error: GetCharacterListError, shouldReload: Bool) {
        guard shouldReload else { return }
        let errorState = dependencies.characterListViewMapper.map(from: error)
        state = .showError(errorState)
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
        let getCharacterList: GetCharacterListUseCase
        let characterListViewMapper: CharacterListViewMapper
        init(getCharacterList: GetCharacterListUseCase = GetCharacterList() ,characterListViewMapper: CharacterListViewMapper = DefaultCharacterListViewMapper()) {
            self.getCharacterList = getCharacterList
            self.characterListViewMapper = characterListViewMapper
        }
    }
    
}
