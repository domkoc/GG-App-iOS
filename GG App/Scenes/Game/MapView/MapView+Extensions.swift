//
//  MapView+Extensions.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 31..
//

import Combine
import GoogleMaps
import MapKit

extension MapView {
    final class ViewModel: ObservableObject {
        @Published var marker: GMSMarker
        @Published var mkMapLocation: MapLocation
        @Published var isButtonEnabled = false

        private var doneCallback: (CLLocationCoordinate2D) -> Void

        internal init(doneCallback: @escaping (CLLocationCoordinate2D) -> Void) {
            self.marker = GMSMarker()
            self.mkMapLocation = MapLocation(latitude: 0, longitude: 0)
            self.doneCallback = doneCallback
        }

        func doneSelecting() {
            self.doneCallback(self.marker.position)
        }
    }
}
