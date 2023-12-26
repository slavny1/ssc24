//
//  MainViewModel.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 19/11/23.
//

import Foundation
import CoreMotion

class MainViewModel: ObservableObject {

    @Published var heading: Double = 0
    @Published var north: Double = 0

    private let motionManager = MotionManager()
    private let locationManager = LocationManager()

    init() {
        startUpdateMotionData()
    }

    private func startUpdateMotionData() {
        motionManager.startUpdates { [weak self] motion, error in
            guard let motion = motion, error == nil else { return }
            //            let motionData = MotionDataModel(
            //                pitch: motion.attitude.pitch,
            //                roll: motion.attitude.roll,
            //                yaw: motion.attitude.yaw
            //            )
            //            self?.heading = motion.attitude.yaw * 360 / .pi
            self?.updateHeading(motion)
        }
    }

    private func updateHeading(_ motion: CMDeviceMotion) {
        self.heading = motion.heading
        print(heading)
    }

    deinit {
        motionManager.stopUpdate()
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
    /// - Warning: Ensure that the `latitude` and `longitude` properties of the `Point` struct are represented in degrees.
    ///
    private func calculateBearing(from startPoint: Point, to endPoint: Point) -> Double {
        
        let endLngRad = makeRadians(endPoint.lng)
        let endLatRad = makeRadians(endPoint.lat)
        
        let startLngRad = makeRadians(startPoint.lng)
        let startLatRad = makeRadians(startPoint.lat)
        
        let y = sin(endLngRad - startLngRad) * cos(endLatRad)
        let x = cos(startLatRad) * sin(endLatRad) - sin(startLatRad) * cos(endLatRad) * cos(endLngRad - startLngRad)
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
    /// - Warning: Ensure that the `latitude` and `longitude` properties of the `Point` struct are represented in degrees.
    ///
    private func calculateBearingTwo(from startPoint: Point, to endPoint: Point) -> Double {
        
        let endLngRad = makeRadians(endPoint.lng)
        let endLatRad = makeRadians(endPoint.lat)
        
        let startLngRad = makeRadians(startPoint.lng)
        let startLatRad = makeRadians(startPoint.lat)
        
        let deltaPhi = log(tan(endLatRad / 2 + .pi / 4) / tan(startLatRad / 2 + .pi / 4))
        let deltaLon = abs(endLngRad - startLngRad)
        let bearing = atan2(deltaLon, deltaPhi)
        // Since atan2 returns values in the range -π ... +π (that is, -180° ... +180°), to normalise the result to a compass bearing (in the range 0° ... 360°, with −ve values transformed into the range 180° ... 360°), convert to degrees and then use (θ+360) % 360, where % is (floating point) modulo
        let angle = (bearing * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
        return angle
    }
    
    private func makeRadians(_ coordinate: Double) -> Double {
        return coordinate * .pi / 180
    }

    func calculateAdjustedAngle(heading: Double, pointOne: Point, pointTwo: Point) -> Double {
        let bearing = calculateBearing(from: pointOne, to: pointTwo)
        let adjustedAngle = heading + bearing
        return adjustedAngle
    }

}
