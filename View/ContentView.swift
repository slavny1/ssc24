//
//  ContentView.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 19/11/23.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    
    @ObservedObject private var viewModel = MainViewModel()
    @State var anglesArray: [Int] = []
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Point.name, order: .forward) var points: [Point]
    
    var home: Point? {
        points.first(where: { $0.home == true })
    }
    
    var body: some View {
        ZStack {
            CircleView(
                north: $viewModel.north, anglesArray: anglesArray
            )
            .rotationEffect(Angle(degrees: viewModel.north))
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    ListView()
                } label: {
                    Image(systemName: "list.star")
                }
            }
        })
        .onAppear() {
            if let home = points.first(where: { $0.home }) {
                anglesArray = points
                    .filter{ !$0.home }
                    .map {
                        Int(viewModel.calculateAdjustedAngle(
                            pointOne: home,
                            pointTwo: $0)
                        )
                    }
            }
        }
    }
}
