//
//  SwiftUIView.swift
//  SwiftStudentChallenge
//
//  Created by Вячеслав Горев on 25/12/2023.
//

import SwiftUI
import PhotosUI

struct EditLocationView: View {

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context

    @State var name: String = ""
    @State var city: String = ""
    @State var lat: String = ""
    @State var lng: String = ""

    @State var selectedImage: PhotosPickerItem?
    @State var selectedImageData: Data?

    @State var isCoordinateField = false

    @State var cities: [City] = []
    @State var filtredCities: [City] = []

    private var maxWidth: CGFloat { min(UIScreen.main.bounds.width / 2, 195) }

    var point: Point?

    private var isSaveDisabled: Bool {
        name.isEmpty || lat.isEmpty || lng.isEmpty || abs(Double(lng) ?? 0) > 180 || abs(Double(lat) ?? 0) > 90
    }

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {

            PhotosPicker(selection: $selectedImage) {
                if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: maxWidth)
                } else {
                    VStack {
                        Image("\(Int.random(in: 1...4))")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: maxWidth)
                        Text("Change photo")
                            .font(.system(size: 14, weight: .regular, design: .default))
                    }
                }
            }
            .padding(.top, 50)
            .padding(.bottom, 50)
            .onChange(of: selectedImage) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }

            HStack {
                Text("Name:")
                CustomTextField("Enter unique name", text: $name)
            }
            .modifier(TextFieldModifier())

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

            if city.count > 3 && (lat.isEmpty && lng.isEmpty) {
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
                .frame(maxHeight: 150)
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
            }

            Spacer()
        }
        .frame(maxWidth: 390)
        .padding(.horizontal)
        .onAppear() {
            cities = loadCities()
            if let point = point {
                name = point.name
                city = point.city ?? ""
                lat = String(format: "%0.1f", point.lat)
                lng = String(format: "%0.1f", point.lng)
                selectedImageData = point.profileImage
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
        let newPoint = Point(lat: Double(lat) ?? 0, lng: Double(lng) ?? 0, name: name, home: false, city: city, profileImage: selectedImageData)
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
}
