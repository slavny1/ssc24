//
//  SwiftUIView.swift
//  
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import SwiftUI

struct OnboardingView: View {
    var data: OnboardingData
    var completionHandler: () -> Void
    var body: some View {
        VStack {

            Text(data.primaryText)
                .font(.system(size: 24, weight: .bold))
                .padding(.bottom, 10)
            Text(data.secondaryText)
                .padding(.bottom, 50)
                .padding(.horizontal)
                .font(.system(size: 18, weight: .regular))
                .multilineTextAlignment(.center)

            Button {
                completionHandler()
            } label: {
                Text("Skip onboarding")
                    .font(.system(size: 16, weight: .regular))
            }

        }
    }
}

#Preview {
    OnboardingView(data: OnboardingData.list.first!, completionHandler: { false })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
}
