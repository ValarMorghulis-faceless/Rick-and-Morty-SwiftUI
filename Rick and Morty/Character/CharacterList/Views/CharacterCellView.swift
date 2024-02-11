//
//  CharacterCellView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 11.02.24.
//

import SwiftUI

struct CharacterCellView: View {
    let presentation: CharacterPresenter

    var body: some View {
        ZStack(alignment: .bottom) {
            URLImage(imageURL: presentation.image)
                .scaledToFill()
            Text(presentation.name)
                .font(.customFont(font: .montserratFont, style: .medium, size: .h2))
                .foregroundColor(Color("DefaultColor"))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding([.all], 6)
                .background(Color.primary.colorInvert().opacity(0.50))
            
        }
        .overlay {
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color(presentation.model.status.statusColor), lineWidth: 2)
        }
    }
}
