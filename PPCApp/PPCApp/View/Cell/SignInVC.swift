//
//  SignInVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/10/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class SignInVC: BaseVC{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var passImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 35, height: 35))
        passImage.image = UIImage.fontAwesomeIcon(name: .lock, textColor: UIColor.black, size: CGSize(width: 35, height: 35))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}
