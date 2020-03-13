//
//  AppDelegate.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 05.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let authVC = AuthorizationViewController()
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: - UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role)
        return sceneConfiguration
    }
}
