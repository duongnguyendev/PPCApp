//
//  BaseVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    var presented : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupBackIcon()
    }
    func setupNavBar(){
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont.systemFont(ofSize: 18)]
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.navigationBar()
    }
    
    func setupBackIcon(){
        
        let backImage = UIImage.fontAwesomeIcon(name: .angleLeft, textColor: UIColor.black, size: CGSize(width: 40, height: 40))
        let leftButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(goBack))
        leftButton.imageInsets.right = 20
        leftButton.imageInsets.left = -20
        leftButton.tintColor = UIColor.white
        if presented != nil {
            self.navigationItem.leftBarButtonItem = leftButton
        }
    }
    
    func goBack(){
        if presented! {
            self.dismiss(animated: true, completion: nil)
        }else{
            if let nav = self.navigationController{
                nav.popViewController(animated: true)
            }
        }
    }
    func present(viewController : BaseVC){
        viewController.presented = true
        let nav = UINavigationController(rootViewController: viewController)
        self.present(nav, animated: true, completion: nil)
    }
    func push(viewController : BaseVC){
        viewController.presented = false
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
