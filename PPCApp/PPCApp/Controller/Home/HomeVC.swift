//
//  HomeVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        title = "Home"
        // Do any additional setup after loading the view.
        
        let buttonPush  = UIButton(type: UIButtonType.system)
        buttonPush.setTitle("Push", for: .normal)
        buttonPush.addTarget(self, action: #selector(pushDetail), for: .touchUpInside)
        
        let buttonPresent  = UIButton(type: UIButtonType.system)
        buttonPresent.setTitle("Present", for: .normal)
        buttonPresent.addTarget(self, action: #selector(presentDetail), for: .touchUpInside)
        
        buttonPush.translatesAutoresizingMaskIntoConstraints = false
        buttonPresent.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonPush)
        view.addSubview(buttonPresent)
        
        buttonPush.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        buttonPush.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        buttonPush.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        buttonPush.heightAnchor.constraint(equalToConstant: 40).isActive = true

        buttonPresent.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        buttonPresent.topAnchor.constraint(equalTo: buttonPush.bottomAnchor, constant: 10).isActive = true
        buttonPresent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        buttonPresent.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func pushDetail() {
        let detailVC = PostDetailVC()
        self.push(viewController: detailVC)
    }
    func presentDetail(){
        let detailVC = PostDetailVC()
        self.present(viewController: detailVC)
    }
}
