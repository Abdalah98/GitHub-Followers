//
//  GFTabBarController.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/27/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor   = .systemGreen
        viewControllers                   = [creatSearchNC() ,creatFavoritesNC()]
    }
    
    
    func creatSearchNC() -> UINavigationController{
         let searchVC                     = SearchVC()
         searchVC.title                   = "Search"
         searchVC.tabBarItem              = UITabBarItem(tabBarSystemItem: .search, tag: 0)
         return UINavigationController(rootViewController: searchVC)
     }
     
    
     func creatFavoritesNC() -> UINavigationController{
         let favoritListVC                = FavoritList()
         favoritListVC.title              = "Favorites"
         favoritListVC.tabBarItem         = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
         return UINavigationController(rootViewController: favoritListVC)
     }
  
}
