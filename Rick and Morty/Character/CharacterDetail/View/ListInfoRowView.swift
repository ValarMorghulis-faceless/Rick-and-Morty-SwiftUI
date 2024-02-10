//
//  ListInfoRowView.swift
//  Rick and Morty
//
//  Created by Giorgi Samkharadze on 10.02.24.
//

import SwiftUI

struct ListInfoRowView: View {
    let label: String
    let icon: String
    let value: String
    let colorText: String?
    public init(label: String, icon: String, value: String, colorText: String?) {
        self.label = label
        self.icon = icon
        self.value = value
        self.colorText = colorText
    }
    var body: some View {
        HStack {
            Label {
                Text(label)
                    .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
            } icon: {
                Text(icon)
                    .font(.customFont(font: .montserratFont, style: .medium, size: .h3))
            }
            Spacer()
            Text(value)
                .foregroundColor(Color(colorText ?? "DefaultColor"))
                .font(.customFont(font: .montserratFont, style: .medium, size: .h3))

        }
    }
}

