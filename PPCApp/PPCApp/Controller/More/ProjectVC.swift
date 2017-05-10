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
        title = LanguageManager.shared.localized(string: "projectmanager")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ProjectCell", bundle: nil), forCellReuseIdentifier: "ProjectCell")
    }
    override func setupNavBar() {
        super.setupNavBar()
        addPostButton()
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
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    //MARK: - setup nav
    func addPostButton(){
        let projectButton = UIBarButtonItem(image: UIImage(named: "add_project.png"), style: .done, target: self, action: #selector(handlePost))
        projectButton.customTitle()
        self.navigationItem.rightBarButtonItem = projectButton
    }
    func handlePost(){
        let proDetailVC1 = ProjectDetailVC1()
        proDetailVC1.post.id_user = signin.id
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
    func edit(project: HomeDataModel) {
        let proDetailVC1 = ProjectDetailVC1()
        proDetailVC1.post = project
        present(viewController: proDetailVC1)
    }
    func remove(project: HomeDataModel) {
        ProjectService.shared.deleteProject(id: project.id) { (errMessage) in
            if errMessage == "1"{
                let index = self.projects.index(of: project)
                self.projects.remove(at: index!)
                self.tableView.reloadData()
            }
        }
    }
}
