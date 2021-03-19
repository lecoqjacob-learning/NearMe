//
//  PlaceListView.swift
//  NearMe
//
//  Created by Jacob LeCoq on 3/18/21.
//
//

import MapKit
import SwiftUI

struct PlaceListView: View {
    @Binding var landmarks: [Landmark]
    let currentLocation: CLLocation?
    
    var onTap: () -> ()
    
    private func distance(to location: CLLocation) -> Double {
        return location.distance(from: self.currentLocation!) / 1000
    }
    func test(){
        landmarks.sort(by: { $0.distance(to: currentLocation!) < $1.distance(to: currentLocation!) })
    }
    
    var body: some View {
        VStack {
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.blue)
                .gesture(TapGesture()
                    .onEnded(self.onTap)
                )
            
            List {
                ForEach(landmarks.sorted(by: { $0.distance(to: currentLocation!) < $1.distance(to: currentLocation!) }), id: \.id) { landmark in
                    HStack {
                        Text(landmark.name)
                        Spacer()
                        Text(String(format: "%.01fkm away", landmark.distance(to: self.currentLocation!)))
                    }
                }
                .animation(.spring())
            }.animation(nil)
            
        }.cornerRadius(16)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmarks: .constant([Landmark(placemark: MKPlacemark())]), currentLocation: nil, onTap: {})
    }
}
