//
//  GGAppApp.swift
//  GG App
//
//  Created by Kocka Dominik Csaba on 2022. 10. 23..
//

import GoogleMaps
import SwiftUI

// no changes in your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    private var googleMapsApiKey: String {
        guard let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else {
            fatalError("Couldn't find file 'ApiKeys.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'ApiKeys.plist'.")
        }
        return value
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        GMSServices.provideAPIKey(googleMapsApiKey)
        return true
    }
}

@main
struct GGAppApp: App {
    // inject into SwiftUI life-cycle via adaptor !!!
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ViewFactory.welcomeView()
        }
    }
}
