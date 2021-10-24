//
//  TabBarController.swift
//  AppStore
//
//  Created by 이재웅 on 2021/10/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    private lazy var todayViewController: UIViewController = {
        let viewController = TodayViewController()
        let tabBarItem = UITabBarItem(
            title: "투데이",
            image: UIImage(systemName: "mail"),
            tag: 0
        )
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    private lazy var appViewController: UIViewController = {
        // View 상단에 Embeded를 주기 위해 NavigationController로 설정
        let viewController = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(
            title: "앱",
            image: UIImage(systemName: "square.stack.3d.up"),
            tag: 1
        )
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [todayViewController, appViewController] // viewControllers의 개수 = 탭바의 개수
    }
}
