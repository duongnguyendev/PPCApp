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
    
    func postProject(post: PostDataModel,completion: @escaping (_ errMess: String?)-> Void){
        let url = "property/savefile"
        let parameters = [
            "project_id": post.project_id,
            "country_id": post.country_id,
            "provine_id": post.provine_id,
            "district_id": post.district_id,
            "floor": post.floor,
            "bedroom": post.bedroom,
            "bathroom": post.bathroom,
            "acreage": post.acreage,
            "price": post.price,
            "image": post.fileImage,
            "phone": post.phone,
            "email": post.email,
            "image_overall": post.fileImage_overload,
            "type": post.type,
            "id_user": post.id_user,
            "area_apartment": post.area_apartment,
            "title": post.title,
            "information": post.info,
            "address": post.address,
            "investor": post.investor,
            "ownership": post.ownership,
            "service": post.service,
            "vi": post.langVI ?? 1,
            "en": post.langEN ?? 0,
            "filemulti[]": post.fileMultiImage
        ] as [String : Any]
        apiService.post(url: url, parameters: parameters) { (json, error) in
            if error == nil{
                let message = json?["message"].string ?? ""
                if message == "1"{
                    completion(message)
                }else{
                    completion(nil)
                }
            }
        }
        
    }
}
