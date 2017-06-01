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
import Alamofire
class ProjectService: BaseService{
    static let shared = ProjectService()
    func fetchProjects(idUser: Int,callback: @escaping ProjectManagerCallBack){
        let url = "user/managerproperty?id=\(idUser)"
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
    func postProject(post: HomeDataModel,completion: @escaping (_ errMess: Int?)-> Void){
        let url = "property/savefile"
        
        let projectid = post.project_id
        let countryid = post.country_id
        let provinceid = post.provine_id
        let dictrictid = post.district_id
        let floor = post.floor
        let bedroom = post.bedroom
        let bathroom = post.bathroom
        let acreage = post.acreage
        let type = post.type
        let id_user = post.id_user
        let area_apartment = post.area_apartment
        let price = post.price
        let phone = post.phone
        let email = post.email
        let title = post.title
        let information = post.info
        let address = post.address
        let investor = post.investor
        let ownership = post.ownership
        let service = post.service
        let en = post.langEN!
        let vi = post.langVI!
        
        var parameters = [String: Any]()
        
        parameters = ["project_id": projectid,"country_id": countryid,"province_id": provinceid,"district_id": dictrictid,"floor": floor,"bedroom": bedroom,"bathroom": bathroom,"acreage": acreage,"type": type,"id_user": id_user,"area_apartment": area_apartment,"price": price,"phone":phone,"email": email,"title": title,"information":information,"address": address,"investor": investor,"ownership": ownership,"service": service,"en": en,"vi": vi]
        
        Alamofire.upload(multipartFormData: { (datas) in
            for (key, value) in parameters {
                datas.append("\(value)".data(using: .utf8)!, withName: key)
            }
            datas.append(post.fileImage!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            datas.append(post.fileImage_overall!, withName: "image_overall", fileName: "image_overall.jpeg", mimeType: "image/jpeg")
            if post.fileMultiImage != nil{
                for (imageData) in post.fileMultiImage!{
                    datas.append(imageData, withName: "filemulti[]", fileName: "multiimage.jpeg", mimeType: "image/jpeg")
                }
            }
            
        }, to: apiService.urlFrom(request: url)) { (result) in
            switch result{
            case .success(let value, _, _):
                value.responseJSON(completionHandler: { (response) in
                    let value = response.result.value
                    let json = JSON(value!)
                    let errMess = json["message"].int ?? 0
                    completion(errMess)
                })
            case .failure:
                completion(nil)
                break
            }
        }
    }
    func updateProject(post: HomeDataModel,completion: @escaping (_ errMess: Int?)-> Void){
        let url = "property/updatefile"
        
        let id = post.id
        let projectid = Int(post.project_id)
        let countryid = Int(post.country_id)
        let provinceid = Int(post.provine_id)
        let dictrictid = Int(post.district_id)
        let floor = post.floor
        let bedroom = post.bedroom
        let bathroom = post.bathroom
        let acreage = post.acreage
        let type = post.type
        let id_user = post.id_user
        let area_apartment = post.area_apartment
        let price = post.price
        let phone = post.phone
        let email = post.email
        let title = post.title
        let information = post.info
        let address = post.address
        let investor = post.investor
        let ownership = post.ownership
        let service = post.service
        let en = post.langEN!
        let vi = post.langVI!
        var parameters = [String: Any](minimumCapacity: 24)
        if en == 1{
            parameters = ["id": id,"project_id": projectid,"country_id": countryid,"province_id": provinceid,"district_id": dictrictid,"floor": floor,"bedroom": bedroom,"bathroom": bathroom,"acreage": acreage,"type": type,"id_user": id_user,"area_apartment": area_apartment,"price": price,"email":email,"phone":phone,"title_en": title,"info_en":information,"address_en": address,"investor_en": investor,"ownership_en": ownership,"service_en": service,"en": en,"vi": vi]
        }else if vi == 1{
            parameters = ["id":id,"project_id": projectid,"country_id": countryid,"province_id": provinceid,"district_id": dictrictid,"floor": floor,"bedroom": bedroom,"bathroom": bathroom,"acreage": acreage,"type": type,"id_user": id_user,"area_apartment": area_apartment,"price": price,"phone":phone,"email": email,"title_vi": title,"info_vi":information,"address_vi": address,"investor_vi": investor,"ownership_vi": ownership,"service_vi": service,"en": en,"vi": vi]
        }
        Alamofire.upload(multipartFormData: { (datas) in
            datas.append(post.fileImage!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            datas.append(post.fileImage_overall!, withName: "image_overall", fileName: "image_overall.jpeg", mimeType: "image/jpeg")
            if post.fileMultiImage != nil{
                for (imageData) in post.fileMultiImage!{
                    datas.append(imageData, withName: "filemulti[]", fileName: "multiimage.jpeg", mimeType: "image/jpeg")
                }
            }
            for (key, value) in parameters {
                datas.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }, to: apiService.urlFrom(request: url))
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                })
                
                upload.responseJSON(completionHandler: { (response) in
                    let value = response.result.value
                    let json = JSON(value!)
                    let message = json["message"].int ?? 0
                    completion(message)
                })
            case .failure:
                completion(nil)
                break
            }
        }
    }
    
    func deleteProject(id: Int,completion: @escaping (_ errMess: String?)-> Void){
        let url = "property/delete?id=\(id)"
        apiService.get(url: url) { (json, error) in
            if error == nil{
                let errMess = json?["message"].string ?? ""
                completion(errMess)
            }else{
                completion(nil)
            }
        }
    }
    
    func fetchUpdateProject (id: Int,completion:@escaping (([HomeDataModel]?,Int?)->())){
        let url = "property?id=\(id)"
        apiService.get(url: url) { (json, error) in
            if error == nil{
                var projects = [HomeDataModel]()
                let message = json?["message"].int ?? 0
                if  !(json?["data"]["vi"].isEmpty)!{
                    let json_vi = json?["data"]["vi"]
                    let project_vi = HomeDataModel(json: json_vi!)
                    projects.append(project_vi)
                }
                if !(json?["data"]["en"].isEmpty)!{
                    let json_en = json?["data"]["en"]
                    let project_en = HomeDataModel(json: json_en!)
                    projects.append(project_en)
                }
                completion(projects,message)

            }else{
                
            }
        }
    }
}
