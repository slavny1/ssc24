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
    @State var city: String = ""
    @State var lat: String = ""
    @State var lng: String = ""
    @State var home: Bool = false
    
    var point: Point?
    
    private var isSaveDisabled: Bool {
        name.isEmpty || lat.isEmpty || lng.isEmpty || abs(Double(lng) ?? 0) > 180 || abs(Double(lat) ?? 0) > 90
    }
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            
            HStack {
                Text("Name:")
                CustomTextField("Enter unique name", text: $name)
            }
            .modifier(TextFieldModifier())
            
            HStack {
                Text("City:")
                CustomTextField("Enter city", text: $city)
            }
            .modifier(TextFieldModifier())
            
            
            HStack {
                Text("Lat:")
                CustomTextField("Latitude", text: $lat)
                    .numericOnly(input: $lat)
                    .keyboardType(.decimalPad)
                Button(action: {
                    toggleSign(value: $lat)
                }, label: {
                    Text(Double(lat) ?? 0 >= 0 ? "N" : "S")
                        .padding(.horizontal)
                })
            }
            .modifier(TextFieldModifier())
            
            HStack {
                Text("Lng:")
                CustomTextField("Longtitude", text: $lng)
                    .numericOnly(input: $lng)
                    .keyboardType(.decimalPad)
                Button(action: {
                    toggleSign(value: $lng)
                }, label: {
                    Text(Double(lng) ?? 0 >= 0 ? "E" : "W")
                        .padding(.horizontal)
                })
            }
            .modifier(TextFieldModifier())
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
            ToolbarItem(placement: .destructiveAction) {
                if let point = point, point.home == false {
                    Button {
                        deletePoint(point)
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    savePoint()
                }, label: {
                    Text("Save")
                })
                .disabled(isSaveDisabled)
            }
        }
    }
    
    private func savePoint() {
        presentationMode.wrappedValue.dismiss()
        let newPoint = Point(lat: Double(lat) ?? 0, lng: Double(lng) ?? 0, name: name, home: home)
        context.insert(newPoint)
        if let point = point {
            context.delete(point)
        }
    }
    
    private func deletePoint(_ point: Point) {
        presentationMode.wrappedValue.dismiss()
        context.delete(point)
    }
    
    private func toggleSign(value: Binding<String>) {
        // Check if the lng/ltd can be converted to a valid number
        if var currentValue = Double(value.wrappedValue) {
            currentValue *= -1 // Toggle the sign
            value.wrappedValue = String(currentValue)
        }
    }
    
    private func loadCities() -> [City] {
        var cities: [City] = []
        
        if let fileURL = Bundle.main.url(forResource: "world_cities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                cities = try decoder.decode([City].self, from: data)
            } catch {
                print("Error while reading the file: \(error)")
            }
        }
        
        return cities
    }
}
