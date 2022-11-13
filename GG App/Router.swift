//
//  Router.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 11. 13..
//

import SwiftUI

final class Router: ObservableObject {
    static let shared = Router()

    @Published var path = NavigationPath()

    private init() { }
}
