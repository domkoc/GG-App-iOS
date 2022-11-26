//
//  SingleplayerNavigatorView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 13..
//

import SwiftUI

struct SingleplayerView: View {
    typealias Txt = Strings.SingleplayerView

    @StateObject var vm: ViewModel

    var body: some View {
        NavigationStack(path: $vm.router.path) {
            VStack {
                Text(Txt.Labels.title)
                    .font(.title)
                Spacer()
                Text(Txt.Labels.description)
                Spacer()
                NavigationLink(Txt.Buttons.play) {
                    ViewFactory.gameView(type: .singleplayer)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#if DEBUG
struct SingleplayerNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.singleplayerView()
    }
}
#endif
