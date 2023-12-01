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

    /// Calculates the bearing (angle) between two geographical points using Haversine formula.
    ///
    /// The bearing represents the direction from the starting point to the ending point,
    /// measured in degrees clockwise from true north.
    ///
    /// This formula is for the initial bearing (sometimes referred to as forward azimuth)
    /// which if followed in a straight line along a great-circle arc will take you from the start point to the end point.
    ///
    /// Formula:    θ = atan2( sin Δλ ⋅ cos φ2 , cos φ1 ⋅ sin φ2 − sin φ1 ⋅ cos φ2 ⋅ cos Δλ )
    /// where    φ1,λ1 is the start point, φ2,λ2 the end point (Δλ is the difference in longitude)
    ///
    /// - Parameters:
    ///   - startPoint: The starting point with latitude and longitude coordinates in radians.
    ///   - endPoint: The ending point with latitude and longitude coordinates in radians.
    ///
    /// - Returns: The bearing angle in degrees, measured clockwise from true north.
    ///
    /// - Note: The formula used for calculating the bearing is based on the Haversine formula.
    /// - SeeAlso: `haversineFormula`
    ///
    /// - Warning: Ensure that the `latitude` and `longitude` properties of the `Point` struct are represented in radians.
    ///
    private func calculateBearing(from startPoint: Point, to endPoint: Point) -> Double {
        let y = sin(endPoint.lonRad - startPoint.lonRad) * cos(endPoint.latRad)
        let x = cos(startPoint.latRad) * sin(endPoint.latRad) - sin(startPoint.latRad) * cos(endPoint.latRad) * cos(endPoint.lonRad - startPoint.lonRad)
        let teta = atan2(y, x)
        // Since atan2 returns values in the range -π ... +π (that is, -180° ... +180°), to normalise the result to a compass bearing (in the range 0° ... 360°, with −ve values transformed into the range 180° ... 360°), convert to degrees and then use (θ+360) % 360, where % is (floating point) modulo
        let angle = (teta * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
        return angle
    }

    /// Calculates the bearing (angle) between two geographical points using an alternative method with logariphmic approach.
    ///
    /// The bearing represents the direction from the starting point to the ending point,
    /// measured in degrees clockwise from true north.
    ///
    /// Formula: Δφ = ln( tan( latB / 2 + π / 4 ) / tan( latA / 2 + π / 4) )
    /// Δlon = abs( lonA - lonB )
    /// bearing :  θ = atan2( Δlon ,  Δφ
    ///
    /// - Parameters:
    ///   - startPoint: The starting point with latitude and longitude coordinates in radians.
    ///   - endPoint: The ending point with latitude and longitude coordinates in radians.
    ///
    /// - Returns: The bearing angle in degrees, measured clockwise from true north.
    ///
    /// - Note: This method uses an alternative approach to calculate bearing based on logarithmic and absolute differences of latitude and longitude.
    /// - SeeAlso: `logarithmicBearingFormula`
    ///
    /// - Warning: Ensure that the `latitude` and `longitude` properties of the `Point` struct are represented in radians.
    ///
    private func calculateBearingTwo(from startPoint: Point, to endPoint: Point) -> Double {
        let deltaPhi = log(tan(endPoint.latRad / 2 + .pi / 4) / tan(startPoint.latRad / 2 + .pi / 4))
        let deltaLon = abs(endPoint.lonRad - startPoint.lonRad)
        let bearing = atan2(deltaLon, deltaPhi)
        // Since atan2 returns values in the range -π ... +π (that is, -180° ... +180°), to normalise the result to a compass bearing (in the range 0° ... 360°, with −ve values transformed into the range 180° ... 360°), convert to degrees and then use (θ+360) % 360, where % is (floating point) modulo
        let angle = (bearing * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
        return angle
    }
}
