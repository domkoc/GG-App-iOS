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
        @Published var isUsingGoogleMaps = false
        @Published var streetViewView: GoogleStreetViewView
        @Published var lookaroundViewView: MKLookAroundViewControllerView
        @Published var gameState = GameState.loading
        @Published var error: Error?
        @Published var score = 0
        @Published var timeRemaining = 10000
        @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @Published var pollTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
        @Published var hasAllSubmitted = false
        var tasks: [GameServiceModel.Task] {
            didSet {
                if gameState == .loading, !tasks.isEmpty {
                    advance()
                }
            }
        }
        var currentTask: GameServiceModel.Task? {
            didSet {
                if isUsingGoogleMaps {
                    streetViewView.coordinate = currentTask!.coordinates
                } else {
                    lookaroundViewView.coordinate = currentTask!.coordinates
                }
            }
        }
        var answers: [AnswersDTOAnswers] = []
        var mapView: MapView?
        var navigateBack: (() -> Void)?

        private var gameService: GameServiceProtocol

        init(router: GameRouter, gameService: GameServiceProtocol) {
            self.router = router
            self.streetViewView = GoogleStreetViewView(coordinate: CLLocationCoordinate2D())
            self.lookaroundViewView = MKLookAroundViewControllerView(coordinate: CLLocationCoordinate2D())
            self.gameService = gameService
            self.tasks = []
            self.pollTimer.upstream.connect().cancel()
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
            self.advanceToNextTaskOrRound()
        case .streetView:
            self.gameState = .map
        case .map:
            advanceToScoreboard()
        case .scoreboard:
            self.advanceToNextTaskOrRound()
        case .ended:
            self.endGame()
        }
    }

    func endGame() {
        gameService.submitScore { _, error in
            switch error {
            case .none:
                self.navigateBack?()
            case .some(let error):
                self.error = error
            }
        }
    }

    func advanceToNextTaskOrRound() {
        pollTimer.upstream.connect().cancel()
        if tasks.isEmpty {
            self.getRound()
        } else {
            self.currentTask = self.tasks.popLast()
            self.timeRemaining = Int(self.currentTask?.seconds ?? 90) + 10
            self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            self.gameState = .streetView
        }
    }

    func advanceToScoreboard() {
        self.gameState = .scoreboard
        stopTimer()
        pollTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
        gameService.submitAnswers(
            answers: AnswersDTO(
                username: gameService.username,
                answers: self.answers
            )
        ) { [weak self] gameState, error in
            switch error {
            case .none:
                let player = gameState?.players?.first(where: { $0.username == self?.gameService.username })
                var userScore = player?.score
                self?.score = userScore ?? 0
                if player?.isPlaying == false {
                    self?.gameState = .ended
                } else {
                    var stillWaiting = false
                    var allInNextRound = true
                    gameState?.players?.forEach { player in
                        if player.hasSubmittedAnswer == false {
                            stillWaiting = true
                        } else if player.hasSubmittedAnswer == true {
                            allInNextRound = false
                        }
                    }
                    self?.hasAllSubmitted = !stillWaiting || allInNextRound
                }
            case .some(let error):
                self?.error = error
            }
        }
    }

    func pollState() {
        gameService.getState { [weak self] gameState, error in
            switch error {
            case .none:
                let player = gameState?.players?.first(where: { $0.username == self?.gameService.username })
                if player?.isPlaying == false {
                    self?.gameState = .ended
                } else {
                    var stillWaiting = false
                    var allInNextRound = true
                    gameState?.players?.forEach { player in
                        if player.hasSubmittedAnswer == false {
                            stillWaiting = true
                        } else if player.hasSubmittedAnswer == true {
                            allInNextRound = false
                        }
                    }
                    self?.hasAllSubmitted = !stillWaiting || allInNextRound
                }
            case .some(let error):
                self?.error = error
            }
        }
    }

    func stopTimer() {
        timer.upstream.connect().cancel()
    }
}
