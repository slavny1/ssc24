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
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Point.name, order: .forward) var points: [Point]
    var home: Point? {
        points.first(where: { $0.home == true })
    }
    
    var body: some View {
        VStack {
            //            Text("North: \((viewModel.heading), specifier: "%.0f") degrees")
            //                .padding()
            ZStack {
                CircleView(
                    north: $viewModel.north
                )
                .rotationEffect(Angle(degrees: viewModel.north))
                
                ForEach(points) { point in
                    if let home = home, point.home == false {
                        let angle = viewModel.calculateAdjustedAngle(
                            pointOne: home,
                            pointTwo: point
                        )
                        Image(systemName: "location.north.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(angle))
                    }
                }
            }
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
//        .onAppear() {
//            if let home = points.first(where: { $0.home == true }) {
//                anglesArray = points.map {
//                    return Int(viewModel.calculateAdjustedAngle(
//                        pointOne: home,
//                        pointTwo: $0))
//                }
//            }
//            print(anglesArray)
//        }
    }
}
