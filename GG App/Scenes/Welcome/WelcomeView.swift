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
        VStack {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Welcome to GG App!")
                .padding()
            Spacer()
            Button(Txt.Buttons.createLobbyButton) {
            }
            .buttonStyle(.borderedProminent)
            Button(Txt.Buttons.joinLobbyButton) {
            }
            .buttonStyle(.borderedProminent)
            Button(Txt.Buttons.viewScoreboardButton) {
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(vm: WelcomeView.ViewModel())
    }
}
