//
//  ContentView+ViewModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import Combine
import FlowStacks

protocol ContentViewNavigationProtocol {
    func createLobbyButtonTapped()
    func joinLobbyButtonTapped()
    func viewScoreboardButtonTapped()
}

extension ContentView {
    final class ViewModel: ObservableObject {
        enum Screen {
            case welcomeView
            case lobby
            case game
            case scoreboard
        }

        var root: Screen = .welcomeView
        @Published var routes: Routes<Screen> = []
    }
}

extension ContentView.ViewModel: ContentViewNavigationProtocol {
    func createLobbyButtonTapped() {
        routes.push(.game)
    }

    func joinLobbyButtonTapped() {
        routes.push(.lobby)
    }

    func viewScoreboardButtonTapped() {
        routes.push(.scoreboard)
    }
}
