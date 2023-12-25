//
//  AddNewLocationView.swift
//  SwiftStudentChallenge
//
//  Created by Вячеслав Горев on 25/12/2023.
//

import SwiftUI

struct AddNewLocationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    
    @State var name: String = ""
    @State var lat: String = ""
    @State var lng: String = ""
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            HStack {
                Text("Name:")
                TextField("Input point's name", text: $name)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Lat:")
                TextField("Input latitude", text: $lat)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Lng:")
                TextField("Input longtitude", text: $lng)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add new location")
                    .fontWeight(.semibold)
            }
            ToolbarItem(placement: .topBarTrailing) {
                let point = Point(lat: Double(lat) ?? 0, lng: Double(lng) ?? 0, name: name)
                Button(action: {
                    context.insert(point)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}

#Preview {
    AddNewLocationView()
}
