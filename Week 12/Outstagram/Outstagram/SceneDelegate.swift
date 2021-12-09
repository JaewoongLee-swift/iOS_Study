//
//  SceneDelegate.swift
//  Outstagram
//
//  Created by 이재웅 on 2021/12/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = TabBarController()
        // 윈도우 자체에서 틴트색 결정
        window?.tintColor = .label // .label : 다크모드에선 흰색, 화이트모드에선 검은색
        window?.makeKeyAndVisible()
    }

}
