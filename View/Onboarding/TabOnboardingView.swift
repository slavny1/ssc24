//
//  SwiftUIView.swift
//
//
//  Created by Вячеслав Горев on 20/1/2024.
//

import SwiftUI

struct TabOnboardingView: View {
    @State private var currentTab = 0
    @State var isHomeAdded = false
    var completionHandler: () -> Void
    var body: some View {
        if isHomeAdded {
            OnboardingView(data: OnboardingData.list[3], isHomeAdded: $isHomeAdded)
            Button(action: {
                completionHandler()
            }, label: {
                Text("Finish")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .foregroundColor(.white)
            })
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        } else {
            VStack {
                TabView(selection: $currentTab,
                        content:  {
                    ForEach(OnboardingData.list.dropLast()) { viewData in
                        OnboardingView(data: viewData, isHomeAdded: $isHomeAdded)
                            .tag(viewData.id)
                    }
                })
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                Spacer()

                HStack(spacing: 15) {
                    ForEach(OnboardingData.list.dropLast().indices, id: \.self) { index in
                        Capsule()
                            .frame(width: currentTab == index ? 20 : 7, height: 7)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}
