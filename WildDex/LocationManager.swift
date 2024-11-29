//
//  LocationManager.swift
//  WildDex
//
//  Created by Lexline Johnson on 11/28/24.
//

// Source: https://github.com/codeswift27/weather
// This was an old app I made. I think old me was
// on to something, so I'm borrowing some of my
// code from it.

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var loadingState: LoadingState<CLPlacemark> = .idle
    private var locationContinuation: CheckedContinuation<CLPlacemark, Error>?
    private let manager = CLLocationManager()
    
//    enum LoadingState<CLPlacemark> {
//        case idle, loading, failed(error: Error), loaded(location: CLPlacemark)
//    }
    
    enum LocationError: Error {
        case accessDenied, unknown
    }
    
    override init() {
        super.init()
        manager.delegate = self
        manager.distanceFilter = 10000
//        manager.requestWhenInUseAuthorization()
//        if manager.authorizationStatus == .denied {
//            print("error, authorization denied!")
//            return
//        }
//        manager.startUpdatingLocation()
    }
    
    func requestLocation() async throws -> CLPlacemark {
        guard CLLocationManager.locationServicesEnabled() && manager.authorizationStatus != .denied else {
            print("error, authorization denied!")
            throw NSError(domain: "LocationServicesDisabled", code: 1, userInfo: nil)
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemarks = placemarks else {
                self.locationContinuation?.resume(throwing: error ?? LocationError.unknown)
                self.locationContinuation = nil
                return
            }
            if let placemark = placemarks.last {
                self.locationContinuation?.resume(returning: placemark)
                self.locationContinuation = nil
                return
            }
            self.locationContinuation?.resume(throwing: error ?? LocationError.unknown)
            self.locationContinuation = nil
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error: ", error)
        locationContinuation?.resume(throwing: error)
        locationContinuation = nil
    }
    
//    func getLocation() async {
//        guard let location = location else {
//            print("location not found yet")
//            return
//        }
//        let geocoder = CLGeocoder()
//        do {
//            let placemarks = try await geocoder.reverseGeocodeLocation(location)
//            if let placemark = placemarks.last {
//                self.loadingState = .loaded(location: placemark)
//                return
//            }
//        } catch {
//            self.loadingState = .failed(error: error)
//            print("error converting to placemark")
//        }
//    }
    
//    func loadData() {
//        loadingState = .loading
//        manager.requestWhenInUseAuthorization()
//        if manager.authorizationStatus == .denied {
//            loadingState = .failed(error: LocationError.accessDenied)
//            print("denied!")
//            return
//        }
//        manager.startUpdatingLocation()
//    }
}
