//
//  DependenciesResolver.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import SwiftUI

protocol ResolverProtocol {
    var characterListFactory: CharacterListModuleFactory { get }
}

struct DependenciesResolver: ResolverProtocol {
    let characterListFactory: CharacterListModuleFactory
    
    init() {
        let characterDetailDependencies = CharacterDetailModuleFactory()
        let characterDetailFactory = characterDetailDependencies
        let characterLitDependencies = CharacterListModuleFactory.Dependencies()
        characterLitDependencies.configure { character in
            AnyView(characterDetailFactory.make(character: character))
        }
        characterListFactory = CharacterListModuleFactory(dependencies: characterLitDependencies)
    }
    
}
