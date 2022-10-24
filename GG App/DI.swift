//
//  DI.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import Factory

extension Container {
    static let welcomeView = Factory {
        WelcomeView(vm: welcomeViewModel())
    }
    private static let welcomeViewModel = Factory {
        WelcomeView.ViewModel()
    }

    static let gameView = Factory {
        GameView()
    }

    static let lobbyView = Factory {
        LobbyView()
    }

    static let scoreboardView = Factory {
        ScoreboardView()
    }
}
