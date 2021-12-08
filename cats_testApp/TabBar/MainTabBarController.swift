//
//  MainTabBarController.swift
//  cats_testApp
//
//  Created by pavel on 6.12.21.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let catsVC = CatsViewController()
        let likeCatsVC = LikeCatsViewController()
        
        guard let catsImage = UIImage(systemName: "c.square") else {return}
        guard let likeCatsImage = UIImage(systemName: "heart.text.square") else {return}
        
        tabBar.tintColor = .systemPurple
        viewControllers = [
            generateNavigationController(rootViewController: catsVC, title: "Cats", image: catsImage),
        generateNavigationController(rootViewController: likeCatsVC, title: "My cats", image: likeCatsImage)]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
}
