//
//  ViewFactory.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import Factory

enum ViewFactory {
    static func welcomeView() -> WelcomeView {
        Container.welcomeView()
    }
    static func gameView() -> GameView {
        Container.gameView()
    }
    static func lobbyView() -> LobbyView {
        Container.lobbyView()
    }
    static func scoreboardView() -> ScoreboardView {
        Container.scoreboardView()
    }
}
