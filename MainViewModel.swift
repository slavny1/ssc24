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

    private let motionManager = MotionManager()

    init() {
        startUpdateMotionData()
    }

    private func startUpdateHeadingData() {

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
//        let rotation = atan2(motion.gravity.y, motion.gravity.x) - .pi
//        let degrees = rotation * 180 / .pi
//        self.heading = (degrees + 360).truncatingRemainder(dividingBy: 360)
//
//        let heading = motion.attitude.yaw * 180 / .pi
        self.heading = motion.heading
        print(heading)
    }

    deinit {
        motionManager.stopUpdate()
    }

}
