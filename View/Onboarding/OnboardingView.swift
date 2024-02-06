//
//  SwiftUIView.swift
//
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import SwiftUI

struct OnboardingView: View {
    let data: OnboardingData
    @Binding var isHomeAdded: Bool
    var body: some View {
        VStack {
            Image(data.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: maxWidth * 2, maxHeight: maxWidth * 2)
            Text(data.primaryText)
                .font(.system(size: 24, weight: .bold))
                .padding(.bottom, 10)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            Text(data.secondaryText)
                .padding(.bottom, 20)
                .padding(.horizontal)
                .font(.system(size: 18, weight: .regular))
                .multilineTextAlignment(.center)
            if data.id == 2 {
                OnboardingLocationView(isHomeAdded: $isHomeAdded)
                    .padding(.bottom, 50)
            }
        }
        .frame(maxWidth: maxWidth * 2)
    }
}
