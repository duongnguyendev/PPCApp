//
//  ProjectManager.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/3/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class ProjectVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    let ud = UserDefaults()
    var projects = [HomeDataModel]()
    var signin = SigninModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "projectmanage")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProjectCell", bundle: nil), forCellReuseIdentifier: "ProjectCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        if ud.object(forKey: "user") != nil{
            MoreService.shared.parseSignIn(completion: { (signin) in
                self.signin = signin!
                ProjectService.shared.fetchProjects(idUser: (signin?.id)!) { (mprojects, errMess) in
                    if errMess == 1{
                        self.projects = mprojects
                        self.tableView.reloadData()
                    }
                }
            })
        }else{
            self.projects.removeAll()
            self.tableView.reloadData()
        }

    }
    override func setupNavBar() {
        super.setupNavBar()
        addPostButton()
    }
    //MARK: - setup nav
    func addPostButton(){
        let projectButton = UIBarButtonItem(image: UIImage(named: "add_project.png"), style: .done, target: self, action: #selector(handlePost))
        projectButton.customTitle()
        self.navigationItem.rightBarButtonItem = projectButton
    }
    func handlePost(){
        if ud.object(forKey: "user") != nil{
            let proDetailVC1 = ProjectDetailVC1()
            proDetailVC1.post.id_user = signin.id
            present(viewController: proDetailVC1)
        }else{
            let signinVC = SignInVC()
            signinVC.delegate = self
            present(viewController: signinVC)
        }
    }
    func showAlertController(projects: [HomeDataModel],title: String,message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let EnAction = UIAlertAction(title: "Tiếng Anh", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            let proDetailVC1 = ProjectDetailVC1()
            projects[1].langEN = 1
            projects[1].langVI = 0
            proDetailVC1.post = projects[1]
            self.present(viewController: proDetailVC1)
        }
        let ViAction = UIAlertAction(title: "Tiếng Việt", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            let proDetailVC1 = ProjectDetailVC1()
            projects[0].langEN = 0
            projects[0].langVI = 1
            proDetailVC1.post = projects[0]
            self.present(viewController: proDetailVC1)
        }
        alertController.addAction(EnAction)
        alertController.addAction(ViAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ProjectVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectCell
        cell.project = projects[indexPath.row]
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(view.frame.width * 9 / 16 + 160)
    }
}
extension ProjectVC: ProjectVCDelegate{
    func edit(project: HomeDataModel) {
        ProjectService.shared.fetchUpdateProject(id: project.id) { (projects, errMess) in
            if errMess == 1{
                if (projects?.count)! > 1{
                    self.showAlertController(projects: projects!, title: "", message: "Bạn muốn chọn ngôn ngữ nào!")
                }else{
                    if (projects?[0].lang?.contains("vi"))!{
                        projects?[0].langVI = 1
                    }else{
                        projects?[0].langEN = 1
                    }
                    let proDetailVC1 = ProjectDetailVC1()
                    proDetailVC1.post = (projects?[0])!
                    self.present(viewController: proDetailVC1)
                }
            }
        }
    }
    func remove(project: HomeDataModel) {
        let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn xoá hay không?", preferredStyle: UIAlertControllerStyle.alert)
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            ProjectService.shared.deleteProject(id: project.id) { (errMessage) in
                if errMessage == "1"{
                    let index = self.projects.index(of: project)
                    self.projects.remove(at: index!)
                    self.tableView.reloadData()
                }
            }
        }
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ProjectVC: MoreVCDelegate{
    func SuccessSignIn(signin: SigninModel) {
        MoreService.shared.saveSignIn(signin: signin)
        self.signin = signin
        ProjectService.shared.fetchProjects(idUser: (signin.id)) { (mprojects, errMess) in
            if errMess == 1{
                self.projects = mprojects
                self.tableView.reloadData()
            }
        }
    }
    func SuccessSignUp(signup: SigninModel) {
        
    }
    
}
