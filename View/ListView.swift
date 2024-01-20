//
//  ListView.swift
//  SwiftStudentChallenge
//
//  Created by Вячеслав Горев on 8/12/2023.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Point.name, order: .forward) var points: [Point]
    
    var body: some View {
        List {
            Section {
                if let point = points.first(where: { $0.home == true }) {
                    NavigationLink {
                        EditLocationView(point: point)
                    } label: {
                        HStack {
                            Image(systemName: "house")
                            Text(point.name)
                            Spacer()
                            Image(systemName: "pencil")
                        }
                    }
                } else {
                    NavigationLink {
                        EditLocationView()
                    } label: {
                        HStack {
                            Image(systemName: "house")
                            Text("Set up your home location")
                            Spacer()
                            Image(systemName: "pencil")
                        }
                    }
                }
            }
            
            ForEach (points.filter({ $0.home == false })) { point in
                NavigationLink {
                    EditLocationView(point: point)
                } label: {
                    HStack {
                        if point.home { Image(systemName: "house") }
                        Text(point.name)
                        Spacer()
                        Image(systemName: "pencil")
                    }
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
                    EditLocationView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
