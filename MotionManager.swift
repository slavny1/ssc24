//
//  MotionManager.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 19/11/23.
//

import Foundation
import CoreMotion

class MotionManager {
    private let motionManager = CMMotionManager()

    /// Initiates device motion updates with a specified handler.
    ///
    /// - Parameters:
    ///   - handler: A closure to be called with device motion data or an error.
    ///
    /// - Important: Ensure that the device motion is available before calling this method using `motionManager.isDeviceMotionAvailable`.
    ///
    /// - Note: The function sets the device motion update interval to 0.1 seconds and starts updates on the main thread.
    ///
    /// - Parameter handler: A closure to be executed with device motion data or an error.
    ///
    /// - SeeAlso: `CMMotionManager`
    /// 
    func startUpdates(handler: @escaping (CMDeviceMotion?, Error?) -> Void) {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main, withHandler: handler)
        }
    }

    /// Stops device motion updates.
    ///
    /// - Important: Ensure that the device motion is available before calling this method using `motionManager.isDeviceMotionAvailable`.
    ///
    func stopUpdate() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}
