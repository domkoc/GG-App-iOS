//
//  DI.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import CoreLocation
import Factory

extension Container {
    // MARK: - Game Scene
    private static let gameRouter = Factory(scope: .shared) {
        GameRouter()
    }

    static let singleplayerGameView = Factory {
        GameView(vm: singleplayerGameViewModel())
    }
    static let multiplayerGameView = Factory {
        GameView(vm: multiplayerGameViewModel())
    }
    private static let singleplayerGameViewModel = Factory {
        GameView.ViewModel(router: gameRouter(), gameService: SingleplayerService(rounds: 3))
    }
    private static let multiplayerGameViewModel = Factory {
        GameView.ViewModel(router: gameRouter(), gameService: MultiplayerService())
    }

    static let streetViewView = Factory {
        StreetViewView(vm: streetViewViewModel())
    }
    private static let streetViewViewModel = Factory {
        StreetViewView.ViewModel()
    }

    static let mapView = ParameterFactory<(CLLocationCoordinate2D) -> Void, MapView> { completion in
        MapView(vm: mapViewModel(completion))
    }
    private static let mapViewModel = ParameterFactory<(CLLocationCoordinate2D) -> Void, MapView.ViewModel> { completion in
        MapView.ViewModel(doneCallback: completion)
    }

    static let singleplayerView = Factory {
        SingleplayerView(vm: singleplayerViewModel())
    }
    private static let singleplayerViewModel = Factory(scope: .shared) {
        SingleplayerView.ViewModel(router: gameRouter())
    }

    // MARK: - Lobby Scene
    static let lobbyView = Factory {
        LobbyView()
    }

    // MARK: - Scoreboard Scene
    static let scoreboardView = Factory {
        ScoreboardView(vm: scoreboardViewModel())
    }
    private static let scoreboardViewModel = Factory {
        ScoreboardView.ViewModel()
    }

    // MARK: - Welcome Scene
    static let welcomeView = Factory {
        WelcomeView(vm: welcomeViewModel())
    }
    private static let welcomeViewModel = Factory {
        WelcomeView.ViewModel()
    }
}
