//
//  Profile.swift
//  PPCApp
//
//  Created by NguoiNb on 4/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Photos
class ProfileVC: BaseVC{
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var fullnameImage: UIImageView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addresImage: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var changepassButton: UIButton!
    var profile = SigninModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userImage.image = UIImage.fontAwesomeIcon(name: .user, textColor: .darkGray, size: CGSize(width: 30, height: 30))
        fullnameImage.image = UIImage.fontAwesomeIcon(name: .addressCard, textColor: .darkGray, size: CGSize(width: 30, height: 30))
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
    override func setupNavBar() {
        super.setupNavBar()
        self.addUpdateButton()
    }
    func addUpdateButton(){
        let updateButton = UIBarButtonItem(title: LanguageManager.shared.localized(string: "update") , style: .done, target: self, action: #selector(handleUpdateProfile))
        updateButton.customTitle()
        updateButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = updateButton
    }
    
    func handleUpdateProfile(){
        let updateVC = UpdateProfileVC()
        updateVC.profile = profile
        updateVC.delegate = self
        push(viewController: updateVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = LanguageManager.shared.localized(string: "profile")
        userTextField.text = profile.username
        fullnameTextField.text = profile.fullname
        emailTextField.text = profile.email
        phoneTextField.text = profile.phone
        addressTextField.text = profile.address
        avatarImage.loadImageurl(link: profile.avatar)
    }
    
    @IBAction func handleChangeButton(_ sender: Any) {
        let changeVC = ChangePassVC()
        changeVC.profile = profile
        push(viewController: changeVC)
    }

}
extension ProfileVC: ProfileVCDelegate{
    func SuccessUpdateProfile(profile: SigninModel) {
        self.profile = profile
    }
}
