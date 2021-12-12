//
//  TabBarController.swift
//  Outstagram
//
//  Created by 이재웅 on 2021/12/09.
//

import UIKit

final class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        // 선택하지 않았을 때랑 선택 되었을 때 구분할 수 있는 메소드
        feedViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [feedViewController, profileViewController]
    }
}
