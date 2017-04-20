 //
//  RecuitmentService.swift
//  PPCApp
//
//  Created by NguoiNb on 4/14/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class RecruitmentService: BaseService{
    static let share = RecruitmentService()
    func getRecruitmentData(indexPage:String,completion: @escaping ([RecruitmentDataModel])->Void){
        let url:String = "recruitment/all" + indexPage
        var RecruimentDatas = [RecruitmentDataModel]()
        apiService.get(url: url) { (json, error) in
            if error == nil{
                
                let json = json?["data"]
                json?.array?.forEach({ (json) in
                    let recruitment = RecruitmentDataModel(json: json)
                    RecruimentDatas.append(recruitment)
                })
                
                completion(RecruimentDatas)
            }
            else{
                completion([])
            }
        }
        }
    
}
