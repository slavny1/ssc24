//
//  ListView.swift
//  SwiftStudentChallenge
//
//  Created by Вячеслав Горев on 8/12/2023.
//

import SwiftUI

struct ListView: View {
    
    @State var list: [Point]
    @State var home: Point
    
    var body: some View {
        List {
            Section {
                NavigationLink {
                    EditLocationView(point: $home)
                } label: {
                    HStack {
                        Image(systemName: "house")
                        Text(home.name)
                        Spacer()
                        Image(systemName: "pencil")
                    }
                    .foregroundColor(.black)
                }
            }
            ForEach ($list) { $point in
                NavigationLink {
                    EditLocationView(point: $point)
                } label: {
                    HStack {
                        Text(point.name)
                        Spacer()
                        Image(systemName: "pencil")
                    }
                    .foregroundColor(.black)
                    
                }
            }
           
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Your locations")
                    .font(.system(size: 20, weight: .semibold))
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AddNewLocationView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct EditLocationView: View {
    
    @Binding var point: Point
    @Environment(\.presentationMode) var presentationMode
    
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
                    // implement logit for editing point's data
                    
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}

struct AddNewLocationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    
    @State var name: String = ""
    @State var lat: String = ""
    @State var lng: String = ""
//    @State var isHome: Bool = false
    
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
//            Toggle(isOn: $isHome, label: {
//                Text("Set up as a home location")
//            })
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
//                    points.append(Point(lat: Double(lat) ?? 0, lng: Double(lng) ?? 0, name: name))
                    context.insert(point)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}

//#Preview {
//    NavigationStack {
//        ListView(list: points, home: home)
//    }
//}
//#Preview {
//    NavigationStack {
//        EditLocationView(point: .constant(points[0]))
//    }
//}
#Preview {
    NavigationStack {
        AddNewLocationView()
    }
}
