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
        List {
            ForEach(vm.scoreboardDummyData.players!, id: \.username) { player in
                HStack {
                    Text(player.username!)
                    Spacer()
                    Text("\(player.score!)")
                }
            }
        }
        .navigationTitle(Txt.navigationTitle)
    }
}

struct ScoreboardView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.scoreboardView()
    }
}
