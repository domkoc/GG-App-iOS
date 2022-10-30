//
//  ScoreboardView+ViewModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 30..
//

import Combine
import SwaggerClient

extension ScoreboardView {
    final class ViewModel: ObservableObject {
        var scoreboardDummyData: ScoreboardDTO {
            var players: [ScoreboardDTOPlayers] = .init()
            for i in 1...10 {
                players.append(ScoreboardDTOPlayers(username: "Player\(i)", score: Int.random(in: 100..<10000)))
            }
            return ScoreboardDTO(players: players)
        }
    }
}
