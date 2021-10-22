//
//  SceneDelegate.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

// 기본 scene메소드만 사용
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
//        let rootViewcontroller = 내가만들 뷰컨트롤러()
//        let rootNavigationController = UINavigationController(rootViewController: 내가만들 뷰컨트롤러)
        
        self.window?.rootViewController = TabBarController()
        self.window?.makeKeyAndVisible()
    }
// 사용하지 않는 scene메소드들은 모두 삭제
}

