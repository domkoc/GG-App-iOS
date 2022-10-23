//
//  ContentView.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import FlowStacks
import SwiftUI

struct ContentView: View {
    @StateObject var vm: ViewModel

    var body: some View {
        buildView(for: vm.root, index: .zero)
            .showing($vm.routes, embedInNavigationView: false, buildView: buildView)
    }

    @ViewBuilder private func buildView(for screen: ViewModel.Screen, index: Int) -> some View {
        switch screen {
        case .welcomeView:
            ViewFactory.welcomeView()
        case .lobby:
            ViewFactory.welcomeView() // FIXME: change to game
        case .game:
            ViewFactory.welcomeView() // FIXME: change to lobby
        case .scoreboard:
            ViewFactory.welcomeView() // FIXME: change to scoreboard
        }
    }
}
