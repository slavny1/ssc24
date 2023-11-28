import SwiftUI

final class Point {
    let x: Double
    let y: Double

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

struct ContentView: View {

    @ObservedObject private var viewModel = LocationManager()

    let pointOne: Point = Point(x: 40.8375713597235, y: 14.302335735241893)
    let pointTwo: Point = Point(x: 52.10268847827439, y: 23.729019036688)


    var body: some View {
        let angle = 360 - viewModel.heading + calculateAngle(x: pointOne, y: pointTwo)

        VStack {
            Text("North: \((viewModel.heading), specifier: "%.0f") degrees")
                .padding()
            Text("Point: \((angle), specifier: "%.0f") degrees")
                .padding()
            Image(systemName: "location.north.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: 360 - viewModel.heading))
            
            Image(systemName: "location.north.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: angle))
        }.onAppear {
            print("current angle: \(angle)")
        }
    }

    private func calculateAngle(x: Point, y: Point) -> Double {
        let deltaX = abs(y.x - x.x)
        let deltaY = abs(y.y - x.y)
        let angle = atan2(deltaY, deltaX) * 180 / .pi
        print(angle)
        return angle
    }
}
