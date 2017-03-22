//
//  NewsVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class NewsVC: BaseVC {
    
//    var news = [NewDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        title = "News"
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//       APIService.shareInstanse.getNews { (news) in
//            self.news = news
//        }
        
        
    }


}
