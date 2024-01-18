//
//  LocationManager.swift
//  SwiftStudentChallenge
//
//  Created by Viacheslav on 21/11/23.
//

import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate {

    var heading: PassthroughSubject<Double, Never>

    private var locationManager = CLLocationManager()

    override init() {
        heading = .init()
        super.init()
        setupLocationManager()
    }

    /// Configures and sets up the location manager for heading updates.
    ///
    /// This function sets the delegate, requests location authorization, and starts updating the heading if available.
    ///
    /// - Important: Ensure that the `locationManager` property is properly initialized before calling this method.
    ///
    /// - Note: The function checks if heading updates are available before initiating the updates.
    ///
    /// - SeeAlso: `CLLocationManager`
    /// 
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.headingAvailable() {
            locationManager.headingFilter = 1
            locationManager.startUpdatingHeading()
        }
    }

    /// Informs the delegate that the location manager has received an updated heading.
    ///
    /// - Parameters:
    ///   - manager: The location manager object reporting the event.
    ///   - newHeading: The updated heading information, represented by a `CLHeading` object.
    ///
    /// - Important: This method is called whenever the device's heading changes.
    ///
    /// - Note: The `heading` property of the calling object is updated with the true heading information from `newHeading`.
    /// - I use trueHeading which is true 90 lat / 0 long but in case you need a magnetic heading change to .magneticHeading optiona
    ///
    /// - SeeAlso: `CLLocationManager`, `CLHeading`
    ///
    /// - Warning: The `newHeading` parameter should not be `nil`, and the `heading` property is updated with the true heading information.
    ///
    internal func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading.send(360 - newHeading.trueHeading)
    }

    /// Notifies the delegate that the location manager was unable to retrieve the user's location due to an error.
    ///
    /// - Parameters:
    ///   - manager: The location manager object reporting the error.
    ///   - error: An error object containing details about why location retrieval failed.
    ///
    /// - Important: This method is called when an error occurs during location retrieval.
    ///
    /// - Note: The error description is printed to the console using `print`.
    ///
    /// - SeeAlso: `CLLocationManager`, `Error`
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
