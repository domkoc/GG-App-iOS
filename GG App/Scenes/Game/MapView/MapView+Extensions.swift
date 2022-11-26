//
//  MapView+Extensions.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 31..
//

import Combine
import GoogleMaps

extension MapView {
    final class ViewModel: ObservableObject {
        @Published var marker: GMSMarker
        @Published var isButtonEnabled = false

        private var doneCallback: (CLLocationCoordinate2D) -> Void

        internal init(doneCallback: @escaping (CLLocationCoordinate2D) -> Void) {
            self.marker = GMSMarker()
            self.doneCallback = doneCallback
        }

        func doneSelecting() {
            self.doneCallback(self.marker.position)
        }
    }
}
