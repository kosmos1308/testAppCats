//
//  SceneDelegate.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
    }
}
