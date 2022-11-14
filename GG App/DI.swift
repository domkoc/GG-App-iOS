//
//  DI.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import Factory

extension Container {

    // MARK: - Welcome Scene
    static let welcomeView = Factory {
        WelcomeView(vm: welcomeViewModel())
    }
    private static let welcomeViewModel = Factory {
        WelcomeView.ViewModel()
    }

    // MARK: - Game Scene
    static let singleplayerGameView = Factory {
        GameView(vm: singleplayerGameViewModel())
    }
    static let multiplayerGameView = Factory {
        GameView(vm: multiplayerGameViewModel())
    }
    private static let singleplayerGameViewModel = Factory {
        GameView.ViewModel(gameService: SingleplayerService(rounds: 3))
    }
    private static let multiplayerGameViewModel = Factory {
        GameView.ViewModel(gameService: MultiplayerService())
    }

    static let streetViewView = Factory {
        StreetViewView(vm: streetViewViewModel())
    }
    private static let streetViewViewModel = Factory {
        StreetViewView.ViewModel()
    }

    static let mapView = Factory {
        MapView(vm: mapViewModel())
    }
    private static let mapViewModel = Factory {
        MapView.ViewModel()
    }

    static let singleplayerView = Factory {
        SingleplayerView(vm: singleplayerViewModel())
    }
    private static let singleplayerViewModel = Factory {
        SingleplayerView.ViewModel()
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
}
