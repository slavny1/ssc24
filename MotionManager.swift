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

    func startUpdates(handler: @escaping (CMDeviceMotion?, Error?) -> Void) {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main, withHandler: handler)
        }
    }

    func stopUpdate() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}
