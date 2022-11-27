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
        ZStack {
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
                    HStack {
                        if vm.hasAllSubmitted {
                            Button(Txt.Buttons.next) {
                                vm.advance()
                            }
                        } else {
                            Button("reload") {
                                vm.pollState()
                            }
                        }
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
            VStack {
                if vm.gameState == .streetView || vm.gameState == .map {
                    Text(vm.timeRemaining.description)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                }
                Spacer()
            }
        }.onAppear {
            vm.navigateBack = {
                presentationMode.wrappedValue.dismiss()
            }
            vm.onAppear()
        }
        .onReceive(vm.timer) { _ in
            if vm.timeRemaining > 0 {
                vm.timeRemaining -= 1
            } else {
                vm.answers.append(AnswersDTOAnswers(title: vm.currentTask?.title, coordinates: RoundDTOCoordinates()))
                vm.advanceToScoreboard()
                print("timesup")
                vm.timer.upstream.connect().cancel()
            }
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
