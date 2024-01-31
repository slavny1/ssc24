//
//  SwiftUIView.swift
//
//
//  Created by Viacheslav on 30/01/24.
//

import SwiftUI

struct OnboardingLocationView: View {

    @Environment(\.modelContext) private var context

    @State var name: String = "Current home"
    @State var city: String = ""
    @State var lat: String = ""
    @State var lng: String = ""

    @State var isCoordinateField = false
    @Binding var isHomeAdded: Bool

    @State var cities: [City] = []
    @State var filtredCities: [City] = []

    private var maxWidth: CGFloat { min(UIScreen.main.bounds.width / 2, 195) }

    private var isSaveDisabled: Bool {
        name.isEmpty || lat.isEmpty || lng.isEmpty || abs(Double(lng) ?? 0) > 180 || abs(Double(lat) ?? 0) > 90
    }

    private var isValidCoordinates: Bool {
        abs(Double(lng) ?? 0) > 180 || abs(Double(lat) ?? 0) > 90
    }
    var body: some View {
        VStack {
            HStack {
                Text("City:")
                CustomTextField("Enter city", text: $city)
                    .onChange(of: city) { oldValue, newValue in
                        filtredCities = cities.filter { $0.name.lowercased().hasPrefix(city.lowercased()) }
                        if !oldValue.isEmpty && newValue.isEmpty {
                            lat = ""
                            lng = ""
                        }
                    }
            }
            .modifier(TextFieldModifier())

            if city.count > 3 && (lat.isEmpty || lng.isEmpty) {
                List(filtredCities, id: \.self) { city in
                    Button(action: {
                        self.city = city.name
                        self.lat = city.lat
                        self.lng = city.lng
                    }, label: {
                        Text(city.name)
                    })
                }
                .listStyle(.inset)
                .frame(minHeight: 150)
            }

            Button(action: {
                isCoordinateField.toggle()
            }, label: {
                Text("-- Or enter precise coordinates below --")
                    .font(.system(size: 14, weight: .regular, design: .default))
            })

            if isCoordinateField {
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

                if isValidCoordinates {
                    Text("-- Enter valid coordinates --")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundStyle(.red)
                }
            }

            Button(action: {
                savePoint()
                isHomeAdded.toggle()
            }, label: {
                Text("Save")
                    .padding()
                    .foregroundColor(.white)
            })
            .disabled(isSaveDisabled)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
        }
        .onAppear() {
            cities = loadCities()
        }
    }

    private func savePoint() {
        let newPoint = Point(lat: Double(lat) ?? 0, lng: Double(lng) ?? 0, name: name, home: true, city: city, profileImage: nil)
        context.insert(newPoint)
    }

    private func loadCities() -> [City] {
        var cities: [City] = []

        if let fileURL = Bundle.module.url(forResource: "world_cities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                cities = try decoder.decode([City].self, from: data)
                print("Data decoded")
                print(cities[0])
            } catch {
                print("Error while reading the file: \(error)")
            }
        } else {
            print("world_cities.json file not found in the main bundle.")
        }
        print("Number of cities: \(cities.count)")
        return cities
    }

    private func toggleSign(value: Binding<String>) {
        // Check if the lng/ltd can be converted to a valid number
        if var currentValue = Double(value.wrappedValue) {
            currentValue *= -1 // Toggle the sign
            value.wrappedValue = String(currentValue)
        }
    }
}
