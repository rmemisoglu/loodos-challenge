//
//  AppDelegate.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 19.11.2020.
//

import UIKit
import Firebase

var remoteConfig = RemoteConfig.remoteConfig()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.backgroundColor = UIColor(named: "BlueColor")
        navigationBarAppearace.barTintColor = UIColor(named: "BlueColor")
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBarAppearace.titleTextAttributes = textAttributes
        UINavigationBar.appearance().isTranslucent = false
        
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

