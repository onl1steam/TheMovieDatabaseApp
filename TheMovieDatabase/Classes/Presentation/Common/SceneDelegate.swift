//
//  SceneDelegate.swift
//  TheMovieDatabase
//
//  Created by Рыжков Артем on 05.03.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil else { return }
    }
}
