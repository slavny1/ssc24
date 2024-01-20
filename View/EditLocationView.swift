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
    @State var home: Bool = false
    
    var point: Point?
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            HStack {
                Text("Name:")
                CustomTextField("Input name for a location", text: $name)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 1) // Border
            )

            HStack {
                HStack {
                    Text("Lat:")
                    CustomTextField("Latitude", text: $lat)
                        .numericOnly(input: $lat)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 1) // Border
                )
                
                HStack {
                    Text("Lng:")
                    CustomTextField("Longtitude", text: $lng)
                        .numericOnly(input: $lng)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary, lineWidth: 1) // Border
                )
            }
            
            HStack {
                if let point = point, point.home == true {
                    Button(action: {
                        home.toggle()
                    }, label: {
                        Text("Choose another home")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(.primary)
                            .cornerRadius(10)
                            
                    })
                } else {
                    Button(action: {
                        home.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "house")
                            Text("Set as home")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(.primary)
                        .cornerRadius(10)
                    })
                }
                
                if let point = point {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                        context.delete(point)
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                    }
                }
            }
        }
        .frame(maxWidth: 390)
        .padding(.horizontal)
        .onAppear() {
            if let point = point {
                name = point.name
                lat = String(format: "%0.1f", point.lat)
                lng = String(format: "%0.1f", point.lng)
                home = point.home
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
                    let newPoint = Point(lat: Double(lat) ?? 0, lng: Double(lng) ?? 0, name: name, home: home)
                    context.insert(newPoint)
                    if let point = point {
                        context.delete(point)
                    }
                }, label: {
                    Text("Save")
                })
                .disabled(name.isEmpty || lat.isEmpty || lng.isEmpty)
            }
        }
    }
}
