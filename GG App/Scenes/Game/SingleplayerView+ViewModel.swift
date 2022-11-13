//
//  SingleplayerView+ViewModel.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 13..
//

import Combine

extension SingleplayerView {
    final class ViewModel: ObservableObject {
        @Published var router = GameRouter.shared
    }
}
