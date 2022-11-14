//
//  GameView+ViewModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 13..
//

import Combine
import CoreLocation
import SwiftUI

extension GameView {
    final class ViewModel: ObservableObject {
        @Published var streetViewView: GoogleStreetViewView
        var mapView: MapView

        private var gameService: GameServiceProtocol

        init(gameService: GameServiceProtocol) {
            self.streetViewView = GoogleStreetViewView(coordinate: CLLocationCoordinate2D())
            self.mapView = ViewFactory.mapView()
            self.gameService = gameService

//            gameService.getRound { [weak self] data, _ in
//                self?.streetViewView.vm.coordinates = (data?.tasks.first!.coordinates)!
//            }
        }
        func getRound() {
            gameService.getRound { [weak self] data, _ in
                self?.streetViewView = GoogleStreetViewView(coordinate: (data?.tasks.first!.coordinates)!)
            }
        }
    }
}
