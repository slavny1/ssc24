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

    // This is a current heading of phone from 0
    @State var currentHeading = 0

    @Environment(\.modelContext) private var context
    @Query(sort: \Point.name, order: .forward) var points: [Point]

    var home: Point? {
        points.first(where: { $0.home == true })
    }

    @State var point: Point? = nil

    var body: some View {
        ZStack {
            VStack {
                if let point = point {
                    HStack {
                        Text(home?.city ?? "Home")
                        Spacer()
                        Text(point.city ?? "City")
                    }
                    .padding()
                }
                Spacer()
            }
            drawCompass()
            drawHeadingLabel()
        }
        .navigationTitle(point?.name ?? "Heading")
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

            // I needed to adjust initial North direction to 180 degrees because in UI angle counted from bottom and for Bearing calculation from top. So, I use 180 with +/- sign in order to adjust UI position of a labels and dots.

            // TODO: Note, that in order to avoid it in the future I might implement offset for compass elements with + sign (N and S) vice versa. Think about it.

            firstNorth = Int(180 - round(viewModel.north))
            print(viewModel.north)
            print(firstNorth)

            // Every time view appears I calculate adjusted angle which is an angle for current point from current phone heading (and not from north).

            initializeAnglesArray()
            print(anglesArray)
        }
        .onChange(of: viewModel.north) { oldValue, newValue in

            currentHeading = (360 - Int(round(newValue)) + 180 - firstNorth) % 360

            if let index = anglesArray.firstIndex(of: currentHeading) {
                point = points.filter({ $0.home == false })[index]
            } else {
                point = nil
            }

            if Int(newValue) % 30 == 0 {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }

            // TODO: I needed to implement such complex equation for what contains in anglesArray because in this array bearing angles calculated from current phone Heading and not from an actual bearing for this point. And in order to get this I need to reverse calculations I did before.

            if Int(newValue) == 0 ||
                anglesArray.contains(currentHeading) {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
        }
    }
}
