//
//  ScoreboardView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 24..
//

import SwiftUI

struct ScoreboardView: View {
    typealias Txt = Strings.ScoreboardView

    @StateObject var vm: ViewModel

    var body: some View {
        VStack {
            if let players = vm.scoreData.players {
                if players.isEmpty {
                    Text(Txt.Labels.noHighScores)
                        .font(.title)
                } else {
                    List {
                        ForEach(players, id: \.username) { player in
                            HStack {
                                if let username = player.username {
                                    Text(username)
                                } else {
                                    Text(Txt.Labels.noUsername)
                                }
                                Spacer()
                                if let score = player.score {
                                    Text(score.description)
                                } else {
                                    Text(Txt.Labels.noScore)
                                }
                            }
                        }
                    }
                }
            } else {
                Text(Txt.Labels.noConnection)
                    .font(.title)
            }
        }
        .navigationTitle(Txt.navigationTitle)
        .onAppear(perform: vm.getData)
    }
}

#if DEBUG
struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.scoreboardView()
    }
}
#endif
