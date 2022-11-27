//
//  LobbyView+ViewModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 27..
//

import Combine
import SwaggerClient

extension LobbyView {
    final class ViewModel: ObservableObject {
        @Published var lobbyId = String() {
            didSet {
                isFormEmpty = username.isEmpty || lobbyId.isEmpty
            }
        }
        @Published var username = String() {
            didSet {
                isFormEmpty = username.isEmpty || lobbyId.isEmpty
            }
        }
        @Published var isFormEmpty = true
        @Published var error: Error?
        @Published var isThereAnError = false

        @Published var isShowingGameView = false

        let isPlayerLobbyHost: Bool
        private var multiPlayerGameService: MultiplayerService

        init(isPlayerLobbyHost: Bool, multiPlayerGameService: MultiplayerService) {
            self.isPlayerLobbyHost = isPlayerLobbyHost
            self.multiPlayerGameService = multiPlayerGameService
        }

        func didPressNextButton() {
            multiPlayerGameService.joinLobby(
                lobby: LobbyDTO(
                    username: self.username,
                    lobbyId: self.lobbyId
                )
            ) { [weak self] data, error in
                switch error {
                case .none:
                    print(data)
                    self?.isShowingGameView = true
                case .some(let error):
                    self?.isThereAnError = true
                    self?.error = error
                }
            }
        }

        func didPressStartButton() {
            multiPlayerGameService.createLobby(
                lobby: LobbyDTO(
                    username: self.username,
                    lobbyId: self.lobbyId
                )
            ) { [weak self] data, error in
                switch error {
                case .none:
                    print(data)
                    self?.isShowingGameView = true
                case .some(let error):
                    self?.isThereAnError = true
                    self?.error = error
                }
            }
        }
    }
}
