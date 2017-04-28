//
//  ProjectService.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/24/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import Photos
class ProjectService: BaseService{
    static let shared = ProjectService()
    
    func fetchProjects(idUser: String,callback: @escaping ProjectManagerCallBack){
        let url = "user/managerproperty?id=" + idUser
        apiService.get(url: url) { (json, error) in
            if error == nil{
                let errMess = json?["message"].int ?? -1
                var projects = [HomeDataModel]()
                json?["data"].array?.forEach({ (jsons) in
                    
                    let project = HomeDataModel(json: jsons)
                    projects.append(project)
                })
                DispatchQueue.main.async {
                    return callback(projects,errMess)
                }
            }//end if
        }
    }
    
}
