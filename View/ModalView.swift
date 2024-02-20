//
//  SwiftUIView.swift
//  
//
//  Created by Viacheslav on 20/02/24.
//

import SwiftUI

struct ModalView: View {
    @Binding var isModal: Bool
    var body: some View {
        VStack {
            
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    isModal = false
                }, label: {
                    Text("Ok")
                })
            }
        }
    }
}
