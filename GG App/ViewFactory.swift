//
//  ViewFactory.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import Factory

enum ViewFactory {
    // MARK: - Welcome Scene
    static func welcomeView() -> WelcomeView {
        Container.welcomeView()
    }

    // MARK: - Game Scene
    static func gameView() -> GameView {
        Container.gameView()
    }

    static func mapView() -> MapView {
        Container.mapView()
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
