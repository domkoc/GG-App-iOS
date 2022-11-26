//
//  GameView+ViewModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 13..
//

import Combine
import CoreLocation
import SwaggerClient
import SwiftUI

extension GameView {
    enum GameState {
        case loading
        case ready
        case streetView
        case map
        case scoreboard
        case ended
    }
    final class ViewModel: ObservableObject {
        @Published var router: GameRouter
        @Published var streetViewView: GoogleStreetViewView
        @Published var gameState = GameState.loading
        @Published var isSelectionOnMapDone = false
        @Published var error: Error?
        @Published var score = 0
        var tasks: [GameServiceModel.Task] {
            didSet {
                if gameState == .loading, !tasks.isEmpty {
                    advance()
                }
            }
        }
        var currentTask: GameServiceModel.Task? {
            didSet {
                streetViewView.coordinate = currentTask!.coordinates
            }
        }
        var answers: [AnswersDTOAnswers] = []
        var mapView: MapView?
        var navigateBack: (() -> Void)?

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
            self?.tasks = (data?.tasks ?? []).reversed()
        }
    }

    private func selectedLocation(_ location: CLLocationCoordinate2D) {
        self.answers.append(AnswersDTOAnswers(title: currentTask?.title, coordinates: RoundDTOCoordinates(location)))
        self.advance()
    }

    func advance() {
        switch self.gameState {
        case .loading:
            self.gameState = .ready
        case .ready:
            self.advanceToNextRound()
        case .streetView:
            self.gameState = .map
        case .map:
            advanceToScoreboard()
        case .scoreboard:
            advanceToNextRound()
        case .ended:
            self.navigateBack?()
        }
    }

    func advanceToNextRound() {
        if tasks.isEmpty {
            self.gameState = .ended
        } else {
            self.currentTask = self.tasks.popLast()
            self.gameState = .streetView
        }
    }

    private func advanceToScoreboard() {
        gameService.submitAnswers(
            answers: AnswersDTO(
                username: gameService.username,
                answers: self.answers
            )
        ) { gameState, error in
            switch error {
            case .none:
                self.score += gameState?.score ?? 0
            case .some(let error):
                self.error = error
            }
        }
        self.gameState = .scoreboard
    }
}
