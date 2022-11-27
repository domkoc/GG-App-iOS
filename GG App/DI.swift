//
//  DI.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import CoreLocation
import Factory

extension Container {
    // MARK: - Services
    static let singlePlayerGameService = Factory {
        SingleplayerService(rounds: 3)
    }
    static let multiPlayerGameService = Factory(scope: .shared) {
        MultiplayerService()
    }

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
        GameView.ViewModel(router: gameRouter(), gameService: singlePlayerGameService())
    }
    private static let multiplayerGameViewModel = Factory {
        GameView.ViewModel(router: gameRouter(), gameService: multiPlayerGameService())
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
    static let lobbyView = ParameterFactory<Bool, LobbyView> { isHost in
        LobbyView(vm: lobbyViewModel(isHost))
    }
    private static let lobbyViewModel = ParameterFactory<Bool, LobbyView.ViewModel> { isHost in
        LobbyView.ViewModel(isPlayerLobbyHost: isHost, multiPlayerGameService: multiPlayerGameService())
    }

    static let inLobbyView = Factory {
        InLobbyView(vm: inLobbyViewModel())
    }
    private static let inLobbyViewModel = Factory {
        InLobbyView.ViewModel(multiPlayerGameService: multiPlayerGameService())
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
