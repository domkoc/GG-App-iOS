//
//  GoogleMapsView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 31..
//

import GoogleMaps
import SwiftUI

// swiftlint:disable file_types_order
struct GoogleMapsView: UIViewRepresentable {
    @Binding var marker: GMSMarker

    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(
            marker: $marker
        )
    }

    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: 75.0, longitude: -18.0, zoom: 3)

        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = context.coordinator
        marker.map = mapView
        marker.opacity = 0

        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        marker.opacity = 100
    }
}

class MapCoordinator: NSObject, GMSMapViewDelegate {
    @Binding var marker: GMSMarker

    init(marker: Binding<GMSMarker>) {
        _marker = marker
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
