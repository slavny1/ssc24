import SwiftUI

final class Point {
    let x: Double
    let y: Double

    let latRad: Double
    let lonRad: Double

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
        self.latRad = x * .pi / 180
        self.lonRad = y * .pi / 180
    }
}

struct ContentView: View {

    @ObservedObject private var viewModel = LocationManager()

    let pointOne: Point = Point(x: 40.8375713597235, y: 14.302335735241893)
    let pointTwo: Point = Point(x: 52.10268847827439, y: 23.729019036688)


    var body: some View {
        let angle = (360 - viewModel.heading + calculateBearing(from: pointOne, to: pointTwo)).truncatingRemainder(dividingBy: 360)

        VStack {
            Text("North: \((viewModel.heading), specifier: "%.0f") degrees")
                .padding()
            Text("Point: \((angle), specifier: "%.0f") degrees")
                .padding()
            ZStack {
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
            }
        }.onAppear {
            print("current angle: \(angle)")
        }
    }

    // first approach
    private func calculateBearing(from startPoint: Point, to endPoint: Point) -> Double {
//        let deltaX = abs(y.x - x.x)
//        let deltaY = abs(y.y - x.y)
//        let angle = atan2(deltaY, deltaX) * 180 / .pi
        let y = sin(endPoint.lonRad - startPoint.lonRad) * cos(endPoint.latRad)
        let x = cos(startPoint.latRad) * sin(endPoint.latRad) - sin(startPoint.latRad) * cos(endPoint.latRad) * cos(endPoint.lonRad - startPoint.lonRad)
        let teta = atan2(y, x)
        let angle = (teta * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
        let finalBearing = (angle + 180).truncatingRemainder(dividingBy: 360)


//        print(angle)
//        print(finalBearing)
//        return angle
        return angle
    }

    // second approach

    private func calculateBearingTwo(from startPoint: Point, to endPoint: Point) -> Double {
        let deltaPhi = log(tan(endPoint.latRad / 2 + .pi / 4) / tan(startPoint.latRad / 2 + .pi / 4))
        let deltaLon = abs(endPoint.lonRad - startPoint.lonRad)

        let bearing = atan2(deltaLon, deltaPhi)
        print(bearing)
        let angle = (bearing * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
        print(angle)
        return angle
    }
}
