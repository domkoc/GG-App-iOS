//
//  SingleplayerNavigatorView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 13..
//

import SwiftUI

struct SingleplayerView: View {
    @StateObject var vm: ViewModel

    var body: some View {
        NavigationStack(path: $vm.router.path) {
            NavigationLink("game") {
                ViewFactory.gameView()
            }.buttonStyle(.borderedProminent)
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