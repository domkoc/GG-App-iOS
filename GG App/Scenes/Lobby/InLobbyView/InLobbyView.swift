//
//  InLobbyView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 27..
//

import SwiftUI

struct InLobbyView: View {
    typealias Txt = Strings.InLobbyView

    @StateObject var vm: ViewModel

    var body: some View {
        if let players = vm.gamestate.players {
            VStack {
                List {
                    ForEach(players, id: \.username) { player in
                        if let username = player.username {
                            Text(username)
                        } else {
                            Text(Txt.Labels.noname)
                        }
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(Txt.Buttons.reload, action: vm.pollGameState)
                    Spacer()
                    if vm.multiPlayerGameService.isHost || vm.gamestate.state == .start {
                        Button(Txt.Buttons.start, action: vm.startGame)
                        Spacer()
                    }
                }
            }
            .alert(vm.error?.localizedDescription ?? Txt.Error.unknown, isPresented: $vm.isThereAnError) {
                Button(Txt.Error.Buttons.ok, role: .cancel) { }
            }
        } else {
            VStack {
                Spacer()
                Text(Txt.Labels.loading)
                Text(vm.multiPlayerGameService.lobbyId)
                Spacer()
                Button(Txt.Buttons.reload, action: vm.pollGameState)
            }
            .onAppear(perform: vm.onAppear)
            .alert(vm.error?.localizedDescription ?? Txt.Error.unknown, isPresented: $vm.isThereAnError) {
                Button(Txt.Error.Buttons.ok, role: .cancel) { }
            }
        }
        NavigationLink(isActive: $vm.isShowingGameView) {
            ViewFactory.gameView(type: .multiplayer)
                .onAppear {
                    vm.timer.upstream.connect().cancel()
                }
        } label: {
            EmptyView()
        }
        .onReceive(vm.timer) { _ in
            vm.pollGameState()
        }
    }
}

struct InLobbyView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.inLobbyView()
    }
}
