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
                NavigationLink {
                    EditLocationView(point: home)
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
            ForEach (points) { point in
                NavigationLink {
                    EditLocationView(point: point)
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

#Preview {
    NavigationStack {
        ListView()
    }
}
