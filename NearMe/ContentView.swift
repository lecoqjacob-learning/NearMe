//
//  ContentView.swift
//  NearMe
//
//  Created by Jacob LeCoq on 3/18/21.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var search: String = ""
    @State private var landmarks = [Landmark]()
    @State private var tapped: Bool = false
    
    private var locationManager = LocationManager()
    
    private func getNearbyLandmarks() {
        guard let location = locationManager.location else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response, error == nil else {
                return
            }
            
            let mapItems = response.mapItems
            self.landmarks = mapItems.map {
                Landmark(placemark: $0.placemark)
            }
        }
    }
    
    private func calculateOffset() -> CGFloat {
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height / 4)
        }
        else if self.tapped {
            return 100
        }
        else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    private func onTap() {
        tapped = true
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(landmarks: self.landmarks)
            
            TextField("Search", text: self.$search, onEditingChanged: { _ in }) {
                self.getNearbyLandmarks()
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .offset(y: 44)
            
            PlaceListView(landmarks: self.$landmarks, currentLocation: self.locationManager.location) {
                withAnimation {
                    self.tapped.toggle()
                }
            }
            .offset(y: calculateOffset())
            .animation(.spring())
        } //: ZSTACK
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
