//
//  ViewFactory.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import CoreLocation
import Factory

extension ViewFactory {
    enum GameViewType {
        case singleplayer
        case multiplayer
    }
}

enum ViewFactory {
    // MARK: - Game Scene
    static func gameView(type: ViewFactory.GameViewType) -> GameView {
        switch type {
        case .singleplayer:
            return Container.singleplayerGameView()
        case .multiplayer:
            return Container.multiplayerGameView()
        }
    }

    static func mapView(completion: @escaping (CLLocationCoordinate2D) -> Void) -> MapView {
        Container.mapView(completion)
    }

    static func singleplayerView() -> SingleplayerView {
        Container.singleplayerView()
    }

    static func streetViewView() -> StreetViewView {
        Container.streetViewView()
    }

    // MARK: - Lobby Scene
    static func lobbyView() -> LobbyView {
        Container.lobbyView()
    }

    // MARK: - Scoreboard Scene
    static func scoreboardView() -> ScoreboardView {
        Container.scoreboardView()
    }

    // MARK: - Welcome Scene
    static func welcomeView() -> WelcomeView {
        Container.welcomeView()
    }
}
