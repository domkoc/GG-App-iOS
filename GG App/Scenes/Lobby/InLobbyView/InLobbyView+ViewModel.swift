//
//  InLobbyView+ViewModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 27..
//

import Combine
import SwaggerClient

extension InLobbyView {
    final class ViewModel: ObservableObject {
        var multiPlayerGameService: MultiplayerService
        @Published var gamestate: GameStateDTO
        @Published var loaded = false
        @Published var error: Error?
        @Published var isThereAnError = false
        @Published var isShowingGameView = false

        init(multiPlayerGameService: MultiplayerService) {
            self.multiPlayerGameService = multiPlayerGameService
            self.gamestate = GameStateDTO()
        }
    }
}

extension InLobbyView.ViewModel {
    func onAppear() {
        pollGameState()
    }

    func pollGameState() {
        multiPlayerGameService.getGameState { [weak self] data, error in
            switch error {
            case .none:
                self?.gamestate = data ?? GameStateDTO()
                self?.loaded = true
            case .some(let error):
                self?.error = error
                self?.isThereAnError = true
            }
        }
    }

    func startGame() {
        if self.multiPlayerGameService.isHost {
            multiPlayerGameService.startGame { [weak self] data, error in
                switch error {
                case .none:
                    self?.gamestate = data!
                    self?.isShowingGameView = true
                case .some(let wrapped):
                    self?.error = error
                    self?.isThereAnError = true
                }
            }
        } else {
            self.isShowingGameView = true
        }
    }
}
