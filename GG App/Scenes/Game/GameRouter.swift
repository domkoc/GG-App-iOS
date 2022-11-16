//
//  GameRouter.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 13..
//

import SwiftUI

final class GameRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var isNotOnRoot = false
}
