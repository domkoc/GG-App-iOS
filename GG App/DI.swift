//
//  DI.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import Factory

extension Container {
    static let contentView = Factory {
        ContentView(vm: contentViewModel())
    }
    private static let contentViewModel = Factory {
        ContentView.ViewModel()
    }
}
