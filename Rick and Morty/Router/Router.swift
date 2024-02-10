//
//  Router.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import Foundation
import SwiftUI

protocol RouterProtocol {
    func navigateBack()
    func navigateToRoot()
    func navigateTo(type: any Hashable)
}


public class Router: ObservableObject, RouterProtocol {
    
    @Published public var navPath = NavigationPath()
    
    public init () {}
    
   public func navigateTo(type: any Hashable) {
        navPath.append(type)
    }
 
   public func navigateBack() {
        navPath.removeLast()
    }
    
   public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
