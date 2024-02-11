//
//  ContentView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import SwiftUI

struct ContentView: View {
   private let dependenciesResolver = DependenciesResolver()
    var body: some View {
        TabView {
          //  CharacterListView(viewModel: viewModel)
            dependenciesResolver.characterListFactory.make()
                .tabItem {
                    TabBarIcon.characters.image
                    Text("Characters")
                }
            AnyView(Text("Episodes"))
                .tabItem {
                    TabBarIcon.episodes.image
                    Text("Episodes")
                }
        }
      //  .accentColor(Color("DefaultColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
