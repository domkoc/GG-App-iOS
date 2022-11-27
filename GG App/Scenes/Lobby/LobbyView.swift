//
//  LobbyView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 24..
//

import SwiftUI

struct LobbyView: View {
    typealias Txt = Strings.LobbyView

    @StateObject var vm: ViewModel

    var body: some View {
        VStack {
            Text(Txt.Labels.title)
                .font(.title)
            Spacer()
            if vm.isPlayerLobbyHost {
                VStack(alignment: .leading) {
                    Text(Txt.Host.Labels.lobbyId)
                    Button(vm.lobbyId) {
                        UIPasteboard.general.string = vm.lobbyId
                    }
                    .onAppear {
                        if vm.lobbyId.isEmpty {
                            vm.lobbyId = UUID().description
                        }
                    }
                    Text(Txt.Join.Labels.username)
                    TextField(Txt.Join.Inputs.username, text: $vm.username)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                Spacer()
                Button(Txt.Host.Buttons.start, action: vm.didPressStartButton)
                    .buttonStyle(.borderedProminent)
                    .disabled(vm.isFormEmpty)
            } else {
                VStack(alignment: .leading) {
                    Text(Txt.Join.Labels.lobbyId)
                    TextField(Txt.Join.Inputs.lobbyId, text: $vm.lobbyId)
                    Text(Txt.Join.Labels.username)
                    TextField(Txt.Join.Inputs.username, text: $vm.username)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                Spacer()
                Button(Txt.Join.Buttons.join, action: vm.didPressNextButton)
                    .buttonStyle(.borderedProminent)
                    .disabled(vm.isFormEmpty)
            }
            NavigationLink(isActive: $vm.isShowingGameView) {
                ViewFactory.inLobbyView()
            } label: {
                EmptyView()
            }
        }
        .alert(vm.error?.localizedDescription ?? Txt.Error.unknown, isPresented: $vm.isThereAnError) {
            Button("OK", role: .cancel) { }
        }
    }
}

#if DEBUG
struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.lobbyView(isHost: true)
    }
}
#endif
