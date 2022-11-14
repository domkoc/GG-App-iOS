//
//  ViewFactory.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import Factory

extension ViewFactory {
    enum GameViewType {
        case singleplayer
        case multiplayer
    }
}

enum ViewFactory {
    // MARK: - Welcome Scene
    static func welcomeView() -> WelcomeView {
        Container.welcomeView()
    }

    // MARK: - Game Scene
    static func gameView(type: ViewFactory.GameViewType) -> GameView {
        switch type {
        case .singleplayer:
            return Container.singleplayerGameView()
        case .multiplayer:
            return Container.multiplayerGameView()
        }
    }

    static func streetViewView() -> StreetViewView {
        Container.streetViewView()
    }

    static func mapView() -> MapView {
        Container.mapView()
    }

    static func singleplayerView() -> SingleplayerView {
        Container.singleplayerView()
    }

    // MARK: - Lobby Scene
    static func lobbyView() -> LobbyView {
        Container.lobbyView()
    }

    // MARK: - Scoreboard Scene
    static func scoreboardView() -> ScoreboardView {
        Container.scoreboardView()
    }
}
