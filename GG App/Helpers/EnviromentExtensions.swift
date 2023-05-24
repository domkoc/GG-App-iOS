//
//  EnviromentExtensions.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2023. 05. 24..
//

import SwiftUI

private struct IsUsingGoogleMapsKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var isUsingGoogleMaps: Bool {
        get { self[IsUsingGoogleMapsKey.self] }
        set { self[IsUsingGoogleMapsKey.self] = newValue }
    }
}

extension View {
    func isUsingGoogleMaps(_ isUsingGoogleMaps: Bool) -> some View {
        environment(\.isUsingGoogleMaps, isUsingGoogleMaps)
    }
}
