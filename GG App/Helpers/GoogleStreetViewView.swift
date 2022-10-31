//
//  GoogleStreetViewView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 31..
//

import GoogleMaps
import SwiftUI

struct GoogleStreetViewView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Self.Context) -> GMSPanoramaView {
        let panoView = GMSPanoramaView(frame: .zero)
        panoView.moveNearCoordinate(coordinate)
        return panoView
    }

    func updateUIView(_ mapView: GMSPanoramaView, context: Context) {
    }
}
