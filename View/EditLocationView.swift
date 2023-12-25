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
    
    var point: Point?
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
            HStack {
                Text("Name:")
                CustomTextField("Input point's name", text: $name)
            }
            HStack {
                Text("Lat:")
                CustomTextField("Input latitude", text: $lat)
                    .numericOnly(input: $lat)
            }
            HStack {
                Text("Lng:")
                CustomTextField("Input longtitude", text: $lng)
                    .numericOnly(input: $lat)
            }
            if let point = point {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    context.delete(point)
                } label: {
                    Text("Delete")
                }
            }
        }
        .padding(.horizontal)
        .onAppear() {
            if let point = point {
                name = point.name
                lat = String(format: "%0.4f", point.lat)
                lng = String(format: "%0.4f", point.lng)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                if let point = point {
                    Text(point.name)
                        .fontWeight(.semibold)
                } else {
                    Text("Add new location")
                        .fontWeight(.semibold)
                }
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    let newPoint = Point(lat: Double(lat) ?? 0, lng: Double(lng) ?? 0, name: name)
                    context.insert(newPoint)
                    if let point = point {
                        context.delete(point)
                    }
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
