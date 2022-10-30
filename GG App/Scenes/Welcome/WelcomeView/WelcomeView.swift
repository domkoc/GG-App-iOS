//
//  WelcomeView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import SwiftUI

struct WelcomeView: View {
    typealias Txt = Strings.WelcomeView

    @StateObject var vm: ViewModel

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(Txt.title)
                    .padding()
                Spacer()
                NavigationLink(Txt.Buttons.createLobbyButton) {
                    ViewFactory.gameView()
                } .buttonStyle(.borderedProminent)
                NavigationLink(Txt.Buttons.joinLobbyButton) {
                    ViewFactory.lobbyView()
                } .buttonStyle(.borderedProminent)
                NavigationLink(Txt.Buttons.viewScoreboardButton) {
                    ViewFactory.scoreboardView()
                } .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.welcomeView()
    }
}
