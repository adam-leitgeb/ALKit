//
//  CLLocationCoordinate2D+Equatable.swift
//
//
//  Created by Adam Leitgeb on 10/11/2019.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
