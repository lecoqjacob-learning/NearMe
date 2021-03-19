//
//  Landmark.swift
//  NearMe
//
//  Created by Jacob LeCoq on 3/18/21.
//

import Foundation
import MapKit

struct Landmark {
    
    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        return self.placemark.name ?? ""
    }
    
    var title: String {
        return self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
    
    func distance(to location: CLLocation) -> Double {
        return location.distance(from: CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)) / 1000
    }
}
