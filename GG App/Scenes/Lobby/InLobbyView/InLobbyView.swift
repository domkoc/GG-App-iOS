//
//  InLobbyView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 27..
//

import SwiftUI

struct InLobbyView: View {
    @StateObject var vm: ViewModel

    var body: some View {
        if let players = vm.gamestate.players {
            VStack {
                List {
                    ForEach(players, id: \.username) { player in
                        if let username = player.username {
                            Text(username)
                        } else {
                            Text("noname")
                        }
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button("reload", action: vm.pollGameState)
                    Spacer()
                    if vm.multiPlayerGameService.isHost || vm.gamestate.state == .start {
                        Button("start", action: vm.startGame)
                        Spacer()
                    }
                }
            }
            .alert(vm.error?.localizedDescription ?? "Txt.Error.unknown", isPresented: $vm.isThereAnError) {
                Button("OK", role: .cancel) { }
            }
        } else {
            VStack {
                Spacer()
                Text("loading lobby:")
                Text(vm.multiPlayerGameService.lobbyId)
                Spacer()
                Button("reload", action: vm.pollGameState)
            }
            .onAppear(perform: vm.onAppear)
            .alert(vm.error?.localizedDescription ?? "Txt.Error.unknown", isPresented: $vm.isThereAnError) {
                Button("OK", role: .cancel) { }
            }
        }
        NavigationLink(isActive: $vm.isShowingGameView) {
            ViewFactory.gameView(type: .multiplayer)
        } label: {
            EmptyView()
        }
    }
}

struct InLobbyView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.inLobbyView()
    }
}
