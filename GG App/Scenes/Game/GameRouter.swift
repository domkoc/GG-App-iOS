//
//  GameRouter.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 13..
//

import SwiftUI

final class GameRouter: ObservableObject {
    static let shared = GameRouter()

    @Published var path = NavigationPath()

    private init() { }
}
