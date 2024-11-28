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

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var loadingState: LoadingState<CLPlacemark> = .idle
    private let manager = CLLocationManager()
    
    enum LoadingState<CLPlacemark> {
        case idle, loading, failed(Error), loaded(CLPlacemark)
    }
    
    enum LocationError: Error {
        case accessDenied, unknown
    }
    
    override init() {
        super.init()
        loadingState = .loading
        manager.delegate = self
        manager.distanceFilter = 10000
        manager.requestWhenInUseAuthorization()
        if manager.authorizationStatus == .denied {
            loadingState = .failed(LocationError.accessDenied)
            return
        }
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        loadingState = .loading
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locations.last ?? .init(latitude: 37.3333, longitude: -122.0068)) { placemarks, error in
            guard let placemarks = placemarks else {
                self.loadingState = .failed(error!)
                return
            }
            if let placemark = placemarks.last {
                self.loadingState = .loaded(placemark)
                return
            }
            self.loadingState = .failed(error!)
        }
    }
    
    func loadData() {
        loadingState = .loading
        manager.requestWhenInUseAuthorization()
        if manager.authorizationStatus == .denied {
            loadingState = .failed(LocationError.accessDenied)
            print("denied!")
            return
        }
        manager.startUpdatingLocation()
    }
}
