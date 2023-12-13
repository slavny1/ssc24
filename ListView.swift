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
                Button(action: {
                    list.append(Point(lat: 0, lng: 0, name: "North Pole"))
                }, label: {
                        Image(systemName: "plus")
                    .foregroundColor(.black)
                })
            }
        }
    }
}

struct EditLocationView: View {
    
    @Binding var point: Point
    
    @State var name: String = ""
    @State var lat: String = ""
    @State var lng: String = ""
    
    var body: some View {
        VStack {
            Text(point.name)
            Text("\(point.lat)")
            Text("\(point.lng)")
            TextField(text: $name) {
                Text("Point name")
            }
            TextField(text: $lat) {
                Text("Input latitude")
            }
            TextField(text: $lng) {
                Text("Input longtitude")
            }
        }
    }
}

extension TextField {
    
}

#Preview {
    NavigationStack {
        ListView(list: points, home: home)
    }
}
#Preview {
    NavigationStack {
        EditLocationView(point: .constant(points[0]))
    }
}
