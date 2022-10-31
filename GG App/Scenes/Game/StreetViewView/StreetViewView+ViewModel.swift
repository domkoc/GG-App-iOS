//
//  StreetViewView+ViewModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 31..
//

import Combine
import GoogleMaps

extension StreetViewView {
    final class ViewModel: ObservableObject {
        @Published var coordinates = CLLocationCoordinate2D(latitude: 47.49801715360313, longitude: 19.04027422744737)
    }
}
