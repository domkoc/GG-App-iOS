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
        NavigationLink("game") {
            ViewFactory.streetViewView()
        }.buttonStyle(.borderedProminent)
    }
}

#if DEBUG
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory.gameView()
    }
}
#endif
