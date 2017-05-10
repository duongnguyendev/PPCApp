//
//  Profile.swift
//  PPCApp
//
//  Created by NguoiNb on 4/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import FontAwesome_swift
class ProfileVC: BaseVC {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addresImage: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var changepassButton: UIButton!
    
    var signin = SigninModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Profile"
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        emailImage.image = UIImage.fontAwesomeIcon(name: .envelope, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        phoneImage.image = UIImage.fontAwesomeIcon(name: .phone, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        addresImage.image = UIImage.fontAwesomeIcon(name: .mapMarker, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        
        avatarImage.layer.cornerRadius = (avatarImage.bounds.size.height / 2.0)
        avatarImage.clipsToBounds = true
        
        changepassButton.layer.cornerRadius = 5

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.showProfile()
        
    }
    
    @IBAction func handleChangeButton(_ sender: Any) {
        let changeVC = ChangePassVC()
        changeVC.profile = signin
        push(viewController: changeVC)
    }
    func showProfile(){
        userTextField.text = signin.username
        emailTextField.text = signin.email
        phoneTextField.text = signin.phone
        addressTextField.text = signin.address
        avatarImage.loadImageurl(link: signin.avatar)
    }
}
