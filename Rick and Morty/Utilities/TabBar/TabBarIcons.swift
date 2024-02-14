//
//  TabBarIcons.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import SwiftUI

enum TabBarIcon {
    case characters
    case locations
    case episodes
}

extension TabBarIcon {
    private var imageName: String {
        switch self {
        case .characters:
            return "person.3.fill"
        case .locations:
            return "map.fill"
        case .episodes:
            return "film.stack"
        }
    }

    var image: Image {
        Image(systemName: imageName)
    }
}
