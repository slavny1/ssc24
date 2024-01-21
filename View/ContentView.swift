//
//  ContentView.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 19/11/23.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    
    @ObservedObject var viewModel = MainViewModel()
    @State var anglesArray: [Int] = []
    @State var firstNorth = 0
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Point.name, order: .forward) var points: [Point]
    
    var home: Point? {
        points.first(where: { $0.home == true })
    }
    
    var body: some View {
        ZStack {
            drawCompass()
            drawHeadingLabel()
        }
        .toolbar() {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    ListView()
                } label: {
                    Image(systemName: "list.star")
                }
            }
        }
        .onAppear() {
            firstNorth = 180 - Int(viewModel.north)
            initializeAnglesArray()
        }
    }
}
