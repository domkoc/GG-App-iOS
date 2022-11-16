//
//  GameView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 24..
//

import SwiftUI

struct GameView: View {
    typealias Txt = Strings.GameView

    @StateObject var vm: ViewModel

    var body: some View {
        Group {
            switch vm.gameState {
            case .loading:
                Text(Txt.Labels.loading)
            case.ready:
                Button(Txt.Buttons.ready) {
                    vm.advance()
                }
            case .streetView:
                if vm.tasks.isEmpty {
                    Text("error")
                } else {
                    VStack {
                        vm.streetViewView
                        Button("next") {
                            vm.advance()
                        }
                    }
                }
            case .map:
                VStack {
                    vm.mapView
                }
            case .scoreboard:
                VStack {
                    Text("scoreboard")
                    Spacer()
                    Button("next") {
                        vm.advance()
                    }
                }
            }
        }.onAppear(perform: vm.onAppear)
    }
}

#if DEBUG
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.gameView(type: .multiplayer)
    }
}
#endif
