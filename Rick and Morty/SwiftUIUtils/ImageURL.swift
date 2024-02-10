//
//  ImageURL.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 09.02.24.
//

import SwiftUI

public struct URLImage: View {
    let imageURL:URL?
    
    public init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    public var body: some View {
        AsyncImage(url: imageURL) { image in
            image.image?.resizable()
        }
    }
}
