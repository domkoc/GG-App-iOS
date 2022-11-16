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
    enum GameState {
        case loading
        case ready
        case streetView
        case map
        case scoreboard
    }
    final class ViewModel: ObservableObject {
        @Published var router: GameRouter
        @Published var streetViewView: GoogleStreetViewView
        @Published var gameState = GameState.loading
        @Published var isSelectionOnMapDone = false
        var tasks: [GameServiceModel.Task] {
            didSet {
                if gameState == .loading, !tasks.isEmpty {
                    self.advance()
                } else if gameState != .loading {
                    fatalError("Invalid game state")
                }
                streetViewView.coordinate = tasks.first!.coordinates
            }
        }
        var mapView: MapView?

        private var gameService: GameServiceProtocol

        init(router: GameRouter, gameService: GameServiceProtocol) {
            self.router = router
            self.streetViewView = GoogleStreetViewView(coordinate: CLLocationCoordinate2D())
            self.gameService = gameService
            self.tasks = []
        }
    }
}

extension GameView.ViewModel {
    func onAppear() {
        initializeMap()
        getRound()
    }

    func initializeMap() {
        self.mapView = ViewFactory.mapView { location in
            self.selectedLocation(location)
        }
    }

    func getRound() {
        gameService.getRound { [weak self] data, _ in
            self?.tasks = data?.tasks ?? []
        }
    }

    private func selectedLocation(_ location: CLLocationCoordinate2D) {
        // TODO: Selection handling
        print(location)
        self.advance()
    }

    func advance() {
        switch self.gameState {
        case .loading:
            self.gameState = .ready
        case .ready:
            self.gameState = .streetView
        case .streetView:
            self.gameState = .map
        case .map:
            self.gameState = .scoreboard
        case .scoreboard:
            self.gameState = .loading
        }
    }
}
