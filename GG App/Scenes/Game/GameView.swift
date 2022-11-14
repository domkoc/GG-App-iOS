//
//  GameView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 24..
//

import SwiftUI

struct GameView: View {
    @StateObject var vm: ViewModel

    var body: some View {
        vm.streetViewView
            .onAppear {
                vm.getRound()
            }
    }
}

#if DEBUG
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.gameView(type: .multiplayer)
    }
}
#endif
