//
//  SwiftUIView.swift
//
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import SwiftUI

struct TabOnboardingView: View {
    @State private var currentTab = 0
    var completionHandler: () -> Void
    var body: some View {
        VStack {
            TabView(selection: $currentTab,
                    content:  {
                ForEach(OnboardingData.list) { viewData in
                    OnboardingView(data: viewData, completionHandler: completionHandler)
                        .tag(viewData.id)
                }
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer()

            HStack(spacing: 15) {
                ForEach(OnboardingData.list.indices, id: \.self) { index in
                    Capsule()
                        .frame(width: currentTab == index ? 20 : 7, height: 7)
                }
            }
            .padding(.bottom, 50)
        }
    }
}
