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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Project"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProjectCell", bundle: nil), forCellReuseIdentifier: "ProjectCell")
        /*if ud.object(forKey: "user") == nil{
            let signinVC = SignInVC()
            present(viewController: signinVC)
        }*/
    }
    override func setupNavBar() {
        super.setupNavBar()
        addPostButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        /*if ud.object(forKey: "user") != nil{
            ProjectService.shared.fetchProjects(idUser: "8") { (mprojects, errMess) in
                if errMess == 1{
                    self.projects = mprojects
                    self.tableView.reloadData()
                }
             }
        }*/
        ProjectService.shared.fetchProjects(idUser: "8") { (mprojects, errMess) in
            if errMess == 1{
                self.projects = mprojects
                self.tableView.reloadData()
            }
        }

    }
    //MARK: - setup nav
    func addPostButton(){
        let projectButton = UIBarButtonItem(image: UIImage(named: "add_project.png"), style: .done, target: self, action: #selector(handlePost))
        projectButton.customTitle()
        self.navigationItem.rightBarButtonItem = projectButton
    }
    func handlePost(){
        //Bug
        /*if ud.object(forKey: "user") != nil{
            let proDetailVC1 = ProjectDetailVC1()
            present(viewController: proDetailVC1)
        }else{
            let signinVC = SignInVC()
            present(viewController: signinVC)
        }*/
        let proDetailVC1 = ProjectDetailVC1()
        present(viewController: proDetailVC1)
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
    func selected(project: HomeDataModel) {
        let proDetailVC1 = ProjectDetailVC1()
        present(viewController: proDetailVC1)
    }
}
