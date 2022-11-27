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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Group {
            switch vm.gameState {
            case .loading:
                Text(Txt.Labels.loading)
            case.ready:
                VStack {
                    Spacer()
                    Text(Txt.Labels.readyDescription)
                    Spacer()
                    Button(Txt.Buttons.ready) {
                        vm.advance()
                    }
                }
            case .streetView:
                VStack {
                    vm.streetViewView
                    Button(Txt.Buttons.next) {
                        vm.advance()
                    }
                }
            case .map:
                VStack {
                    vm.mapView
                }
            case .scoreboard:
                VStack {
                    Text(vm.score.description)
                    Spacer()
                    Button(Txt.Buttons.next) {
                        vm.advance()
                    }
                }
            case .ended:
                VStack {
                    Text(Txt.Labels.gameEnded(vm.score))
                    Button(Txt.Buttons.next) {
                        vm.advance()
                    }
                }
            }
        }.onAppear {
            vm.navigateBack = {
                presentationMode.wrappedValue.dismiss()
            }
            vm.onAppear()
        }
    }
}

#if DEBUG
import SwaggerClient
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.gameView(type: .multiplayer)
    }
}
#endif
