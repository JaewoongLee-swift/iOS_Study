//
//  SceneDelegate.swift
//  Calender
//
//  Created by 이재웅 on 2021/11/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let rootViewController = CalenderViewController()
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        
        self.window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

