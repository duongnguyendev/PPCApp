//
//  MoreService.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/27/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit
class MoreService: BaseService {
    
    static let shared = MoreService()
    let ud = UserDefaults.standard
    
    func getMores(complention: ([MoreDataModel]) ->Void){
        var mores = [MoreDataModel]()
        mores.append(addMore(icon: "recruitment.png", desc: LanguageManager.shared.localized(string: "recruitment")!))
        mores.append(addMore(icon: "partners.png", desc: LanguageManager.shared.localized(string: "partners")!))
        mores.append(addMore(icon: "introduction.png", desc: LanguageManager.shared.localized(string: "about")!))
        mores.append(addMore(icon: "terms.png", desc: LanguageManager.shared.localized(string: "terms")!))
        mores.append(addMore(icon: "setting.png", desc: LanguageManager.shared.localized(string: "setting")!))
        complention(mores)
    }
    func addMore(icon: String,desc: String)-> MoreDataModel{
        
        return MoreDataModel.init(icon: icon, desc: desc)
    }
    
    func getTerms(completion: @escaping ([TermsModel]?)->Void){
        let url = "terms"
        var terms = [TermsModel]()
        apiService.get(url: url) { (jsons, err) in
            if err == nil{
                let json = jsons?["data"].array
                json?.forEach({ (jsons) in
                    let term = TermsModel(json: jsons)
                    terms.append(term)
                })
                
                completion(terms)
            }
            else{
                completion(nil)
            }
        }
    }

    func getPartners(completion: @escaping (([PartnersDataModel]?)->Void)){
        let url = "partners"
        var partners = [PartnersDataModel]()
        apiService.get(url: url) { (json, err) in
            if err == nil{
                let json = json?["data"]
                json?.array?.forEach({ (jsons) in
                    let partner = PartnersDataModel(json: jsons)
                    partners.append(partner)
                    
                })
                completion(partners)
            }
            else{
                completion(nil)
            }
        }
    }
    
    func getRecruitments(completion: @escaping ([RecruitmentDataModel]?)->Void){
        let url  = "recruitment/all"
        var recruitments = [RecruitmentDataModel]()
        apiService.get(url: url) { (json, error) in
            if error == nil{
                let json = json?["data"]
                json?.array?.forEach({ (json) in
                    let recruitment = RecruitmentDataModel(json: json)
                    recruitments.append(recruitment)
                })
                
                completion(recruitments)
            }
            else{
                completion(nil)
            }
        }
    }
    
    func getAbouts(completion:@escaping ([AboutDataModel]?)->Void){
        let url = "aboutus/all"
        var abouts = [AboutDataModel]()
        apiService.get(url: url) { (json, err) in
            if err == nil{
                let json = json?["data"]
                json?.array?.forEach({ (json) in
                    let about = AboutDataModel(json: json)
                    abouts.append(about)
                })
                completion(abouts)
            }
            else{
                completion(nil)
            }
        }
    }
    
    func getSignIn(username: String,password: String,completion: @escaping (SigninModel?,Int?)->Void){
        let url = "user/login"
        let parameters = [
            "username": username,
            "password": password
        ]
        apiService.post(url: url, parameters: parameters) { (jsons, err) in
            if err == nil{
                let message = jsons?["message"].int ?? 0
                let json = jsons?["data"]
                let signin = SigninModel(json: json!)
                completion(signin,message)
            }else{
                completion(nil,-1)
            }
        }
    }
    
    func saveSignIn(signin: SigninModel){
        let dict = ["id": signin.id, "username": signin.username, "fullname": signin.fullname,"email": signin.email,"avatar": signin.avatar,"phone": signin.phone,"address": signin.address] as [String: Any?]
        let json = JSON(dict)
        let signinObject = json.rawString()
        
        ud.set(signinObject, forKey: "user")
        ud.synchronize()
    }
    
    func parseSignIn(completion: @escaping (SigninModel?)->Void)
    {
        let content = ud.object(forKey: "user") as! String
        let encodedString : Data = (content as String).data(using: String.Encoding.utf8)!
        let jsonObj = JSON(data: encodedString)
        if jsonObj != JSON.null {
            let signIn = SigninModel(json: jsonObj)
            completion(signIn)
        }else{
            completion(nil)
        }
    }
    
    func postSignUp(signup: SigninModel,avatar: Data?,completion: @escaping (_ signin: SigninModel?, _ errMess: String?)-> Void){
        let url = "user/create"
        let parameters = [
            "username": signup.username,
            "password": signup.password,
            "fullname": signup.fullname,
            "email": signup.email,
            "phone": signup.phone,
            "address": signup.address
        ]
        Alamofire.upload(multipartFormData: { (datas) in
            for (key, value) in parameters {
                datas.append("\(value)".data(using: .utf8)!, withName: key)
            }
            datas.append(avatar!, withName: "avatar", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            
        }, to: apiService.urlFrom(request: url)) { (result) in
            switch result{
            case .success(let value, _, _):
                value.responseJSON(completionHandler: { (response) in
                    let value = response.result.value
                    let json = JSON(value!)
                    let errMess = json["message"].string ?? ""
                    let signin = SigninModel(json: json["data"])
                    completion(signin,errMess)
                })
                break
            case .failure:
                
                break
            }
        }
    }

    func updateProfile(profile: SigninModel,avatar: Data?,completion: @escaping (_ profile: SigninModel?, _ errMess: Int?)-> Void){
        
        let url = "user/update"
        let parameters = [
            "id": profile.id,
            "username": profile.username,
            "fullname": profile.fullname,
            "email": profile.email,
            "phone": profile.phone,
            "address": profile.address
        ] as [String : Any]
        
        Alamofire.upload(multipartFormData: { (datas) in
            for (key, value) in parameters {
                datas.append("\(value)".data(using: .utf8)!, withName: key)
            }
            if avatar != nil{
                datas.append(avatar!, withName: "avatar", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            }
        }, to: apiService.urlFrom(request: url)) { (result) in
            switch result{
            case .success(let value, _, _):
                value.responseJSON(completionHandler: { (response) in
                    let value = response.result.value
                    let json = JSON(value!)
                    let errMess = json["message"].int ?? -1
                    let profile = SigninModel(json: json["data"])
                    completion(profile,errMess)
                })
                break
            case .failure:
                break
            }
        }
    }
    func updatePassword(id: Int,oldpass: String,newpass: String){
        let url = "user/changepass"
        let parameters = [
            "id": id,
            "password_old": oldpass,
            "password_new": newpass
        ] as [String : Any]
        apiService.post(url: url, parameters: parameters) { (json, error) in
           if error == nil{
                
            }
        }
    }
    
    func forgotPassword(email: String){
        let url = "forgetpass/"
        let parameters = ["email": email]
        apiService.post(url: url, parameters: parameters) { (json, error) in
            if error == nil{
                
            }else{
                
            }
        }
    }
}
