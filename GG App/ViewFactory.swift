//
//  ViewFactory.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import Factory

enum ViewFactory {
    static func welcomeView() -> WelcomeView {
        Container.welcomeView()
    }
}
