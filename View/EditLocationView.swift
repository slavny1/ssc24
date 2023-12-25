//
//  SwiftUIView.swift
//  SwiftStudentChallenge
//
//  Created by Вячеслав Горев on 25/12/2023.
//

import SwiftUI

struct EditLocationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    
    @State var name: String = ""
    @State var lat: String = ""
    @State var lng: String = ""
    
    var point: Point
    
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
            Button {
                self.presentationMode.wrappedValue.dismiss()
                context.delete(point)
            } label: {
                Text("Delete")
            }
            
        }
        .padding(.horizontal)
        .onAppear() {
            name = point.name
            lat = String(format: "%0.4f", point.lat)
            lng = String(format: "%0.4f", point.lng)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(point.name)
                    .fontWeight(.semibold)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    let newPoint = Point(lat: Double(lat) ?? 0, lng: Double(lng) ?? 0, name: name)
                    context.insert(newPoint)
                    context.delete(point)
                    
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}

#Preview {
    EditLocationView(point: home)
}
