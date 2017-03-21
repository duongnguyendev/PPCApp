//
//  MainTabVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import FontAwesome_swift

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabHome = HomeVC()
        let homeNav = UINavigationController(rootViewController: tabHome)
        let homeIcon = UIImage.fontAwesomeIcon(name: .home, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let tabHomeBarItem = UITabBarItem(title: "Home", image: homeIcon, selectedImage: homeIcon)
        homeNav.tabBarItem = tabHomeBarItem
        
        let tabPost = PostVC()
        let PostNav = UINavigationController(rootViewController: tabPost)
        let postIcon = UIImage.fontAwesomeIcon(name: .upload, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let tabPostBarItem = UITabBarItem(title: "Post", image: postIcon, selectedImage: postIcon)
        PostNav.tabBarItem = tabPostBarItem
        
        let tabNews = NewsVC()
        let newsNav = UINavigationController(rootViewController: tabNews)
        let newsIcon = UIImage.fontAwesomeIcon(name: .newspaperO, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let tabNewsBarItem = UITabBarItem(title: "News", image: newsIcon, selectedImage: newsIcon)
        newsNav.tabBarItem = tabNewsBarItem
        
        let tabMore = MoreVC()
        let moreNav = UINavigationController(rootViewController: tabMore)
        let moreIcon = UIImage.fontAwesomeIcon(name: .ellipsisH, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let tabMoreBarItem = UITabBarItem(title: "More", image: moreIcon, selectedImage: moreIcon)
        moreNav.tabBarItem = tabMoreBarItem
        
        self.viewControllers = [homeNav, PostNav, newsNav, moreNav]
    }

}
