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
            for index in 1...10 {
                players.append(ScoreboardDTOPlayers(username: "Player\(index)", score: Int.random(in: 100..<10000)))
            }
            return ScoreboardDTO(players: players)
        }
        @Published var scoreData = ScoreboardDTO()

        func getData() {
            ScoreboardAPI.getScoreboard(completion: updateScore)
        }

        func updateScore(dto: ScoreboardDTO?, error: Error?) {
            if let dto = dto {
                scoreData = dto
            } else if let error = error {
                print(error)
            } else {
                print("Unknown error occured. Please notify the developer!")
            }
        }
    }
}
