//
//  MoreVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
//var Login:Bool = false
class MoreVC: BaseVC,SuccessLogin {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarButton: UIButton!
    let getuser:UserDefaults = UserDefaults()
    var usermodel:SigninModel = SigninModel()
    var mores = [MoreDataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signImage.layer.cornerRadius = 40
        signImage.clipsToBounds = true
        // Do any additional setup after loading the view.
        title = "More"
        
        nameLabel.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        signImage.layer.cornerRadius = 40
        signImage.clipsToBounds = true
        title = "More"
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MoreCell", bundle: nil), forCellReuseIdentifier: "MoreCell")
        MoreService.shared.getMores { (mores) in
            self.mores = mores
            self.tableView.reloadData()
        }
       //login()
        
       login()
       
    }
   
    func getUser(user: SigninModel) {
        self.signImage.loadImageurl(link: user.avatar)
        self.nameLabel.text = user.username
        
    }
    func signUpSuccess(user: SigninModel) {
        self.signImage.loadImageurl(link: user.avatar)
        self.nameLabel.text = user.username

    }
    func updateSuccess(user: SigninModel) {
        self.signImage.loadImageurl(link: user.avatar)
        self.nameLabel.text = user.username
    }
    
    func login(){
        if (getuser.object(forKey: "user") != nil){
            usermodel = SigninModel(dic: getuser.object(forKey: "user") as! Dictionary<String, Any>)
            signImage.loadImageurl(link: usermodel.avatar)
            nameLabel.text = usermodel.username
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    @IBAction func avatarHandle(_ sender: Any) {
        
        if getuser.object(forKey: "user") == nil{
        let signin = SignInVC()
        signin.delegate = self
        
        present(viewController: signin)
            //push(viewController: signin)
        }
        else{
            let profile = Profile()
            profile.delegate = self
            present(viewController: profile)
        }
    }
}
extension MoreVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mores.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell") as! MoreCell
        cell.more = mores[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            //Present Detail Recruitment
            let recruitmentVC = RecruitmentVC()
            present(viewController: recruitmentVC)
        case 1:
            //Present Detail Partners
            let partnersVC = PartnersVC()
            present(viewController: partnersVC)
        case 2:
            //Present Introduction PPC
            let aboutVC = AboutVC()
            present(viewController: aboutVC)
        case 3:
            //Present Detail Terms
            let termsVC = TermsVC()
            present(viewController: termsVC)
        case 4:
            //Present Detail Setting
            let settingVC = SettingVC()
            present(viewController: settingVC)
        default:
            break;
        }
    }
    
}
