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
        @Published var marker = GMSMarker()
    }
}
