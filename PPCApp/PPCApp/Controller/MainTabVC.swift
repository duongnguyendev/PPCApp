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
        // home
        let tabHome = HomeVC()
        let homeNav = UINavigationController(rootViewController: tabHome)
        let homeIcon = UIImage.fontAwesomeIcon(name: .home, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let tabHomeBarItem = UITabBarItem(title: "Home", image: homeIcon, selectedImage: homeIcon)
        tabHomeBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBar(),
                                            NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                                              for: UIControlState.selected)
        homeNav.tabBarItem = tabHomeBarItem
        
        // post
        let tabPost = PostVC()
        let PostNav = UINavigationController(rootViewController: tabPost)
        let postIcon = UIImage.fontAwesomeIcon(name: .upload, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let tabPostBarItem = UITabBarItem(title: "Post", image: postIcon, selectedImage: postIcon)
        tabPostBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBar(),
                                               NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                                              for: UIControlState.selected)
        PostNav.tabBarItem = tabPostBarItem
        
        //news
        let tabNews = NewsVC()
        let newsNav = UINavigationController(rootViewController: tabNews)
        let newsIcon = UIImage.fontAwesomeIcon(name: .newspaperO, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let tabNewsBarItem = UITabBarItem(title: "News", image: newsIcon, selectedImage: newsIcon)
        tabNewsBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBar(),
                                               NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                                              for: UIControlState.selected)
        newsNav.tabBarItem = tabNewsBarItem
        
        
        //more
        let tabMore = MoreVC()
        let moreNav = UINavigationController(rootViewController: tabMore)
        let moreIcon = UIImage.fontAwesomeIcon(name: .ellipsisH, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let tabMoreBarItem = UITabBarItem(title: "More", image: moreIcon, selectedImage: moreIcon)
        tabMoreBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBar(),
                                               NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                                              for: UIControlState.selected)
        moreNav.tabBarItem = tabMoreBarItem
        
        
        self.viewControllers = [homeNav, PostNav, newsNav, moreNav]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }

}
