//
//  Rick_and_MortyApp.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: CharacterTabRouter.self) { $0 }
            }
            .environmentObject(router)
        }
    }
}
