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
        //let homeIcon = UIImage.fontAwesomeIcon(name: .home, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let homeIcon = UIImage(named: "home.png")
        let homeIconSelect = UIImage(named: "home_select.png")
        let tabHomeBarItem = UITabBarItem(title: LanguageManager.shared.localized(string: "home"), image: homeIcon, selectedImage: homeIconSelect)
        tabHomeBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBar(),
                                            NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                                              for: UIControlState.selected)
        homeNav.tabBarItem = tabHomeBarItem
        
        // post
        let tabProject = ProjectVC()
        let projectNav = UINavigationController(rootViewController: tabProject)
        //let postIcon = UIImage.fontAwesomeIcon(name: .upload, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let projectIcon = UIImage(named: "project.png")
        let projectIconSelect = UIImage(named: "project_select.png")
        let tabPostBarItem = UITabBarItem(title: LanguageManager.shared.localized(string: "projectmanage"), image: projectIcon, selectedImage: projectIconSelect)
        tabPostBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBar(),
                                               NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                                              for: UIControlState.selected)
        projectNav.tabBarItem = tabPostBarItem
        
        //news
        let tabNews = NewsVC()
        let newsNav = UINavigationController(rootViewController: tabNews)
        //let newsIcon = UIImage.fontAwesomeIcon(name: .newspaperO, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let newsIcon = UIImage(named: "news.png")
        let newsIconSelect = UIImage(named: "news_select.png")
        let tabNewsBarItem = UITabBarItem(title: LanguageManager.shared.localized(string: "news"), image: newsIcon, selectedImage: newsIconSelect)
        tabNewsBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBar(),
                                               NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                                              for: UIControlState.selected)
        newsNav.tabBarItem = tabNewsBarItem
        
        
        //more
        let tabMore = MoreVC()
        let moreNav = UINavigationController(rootViewController: tabMore)
        //let moreIcon = UIImage.fontAwesomeIcon(name: .ellipsisH, textColor: UIColor.blue, size: CGSize(width: 40, height: 40))
        let moreIcon = UIImage(named: "more.png")
        let moreIconSelect = UIImage(named: "more_select.png")
        let tabMoreBarItem = UITabBarItem(title: LanguageManager.shared.localized(string: "more"), image: moreIcon, selectedImage: moreIconSelect)
        tabMoreBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBar(),
                                               NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                                              for: UIControlState.selected)
        moreNav.tabBarItem = tabMoreBarItem
        
        
        self.viewControllers = [homeNav, projectNav, newsNav, moreNav]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewControllers?[0].title = LanguageManager.shared.localized(string: "home")
        self.viewControllers?[1].title = LanguageManager.shared.localized(string: "projectmanage")
        self.viewControllers?[2].title = LanguageManager.shared.localized(string: "news")
        self.viewControllers?[3].title = LanguageManager.shared.localized(string: "more")
    }

}
