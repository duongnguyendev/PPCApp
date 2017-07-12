//
//  MoreVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
class MoreVC: BaseVC{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signImage: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarButton: UIButton!
    let ud = UserDefaults.standard
    var mores = [MoreDataModel]()
    var signin = SigninModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signImage.layer.cornerRadius = 40
        signImage.clipsToBounds = true
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MoreCell", bundle: nil), forCellReuseIdentifier: "MoreCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if ud.object(forKey: "user") != nil{
            MoreService.shared.parseSignIn(completion: { (signin) in
                self.signin = signin!
                self.signImage.loadImageUsingUrlString(urlString: (signin?.avatar)!)
                self.nameLabel.text = signin?.username
            })
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        title = LanguageManager.shared.localized(string: "more")
        MoreService.shared.getMores { (mores) in
            self.mores = mores
            self.tableView.reloadData()
        }
        if ud.object(forKey: "user") == nil{
            self.signImage.image = UIImage(named: "sign")
            self.nameLabel.text = LanguageManager.shared.localized(string: "sign_inup")
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.mores.removeAll()
    }
    @IBAction func avatarHandle(_ sender: Any) {
        if ud.object(forKey: "user") != nil{
            let profileVC = ProfileVC()
            profileVC.profile = signin
            present(viewController: profileVC)
        }else{
            let signin = SignInVC()
            signin.delegate = self
            present(viewController: signin)
        }
        
    }
}
extension MoreVC: MoreVCDelegate{
    func SuccessSignIn(signin: SigninModel) {
        signImage.loadImageUsingUrlString(urlString: signin.avatar)
        nameLabel.text = signin.username
        MoreService.shared.saveSignIn(signin: signin)
        self.signin = signin
    }
    func SuccessSignUp(signup: SigninModel) {
        signImage.loadImageUsingUrlString(urlString: signup.avatar)
        nameLabel.text = signup.username
        MoreService.shared.saveSignIn(signin: signup)
        self.signin = signup
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
