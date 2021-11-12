//
//  SceneDelegate.swift
//  SubwayStation
//
//  Created by 이재웅 on 2021/11/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        self.window?.rootViewController = UINavigationController(rootViewController: StationSearchViewController())
        window?.makeKeyAndVisible()
        
    }
}

