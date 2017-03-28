//
//  MoreService.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/27/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class MoreService: NSObject {
    
    static let shared = MoreService()
    
    func getMores(complention: ([MoreDataModel]) ->Void){
        var mores = [MoreDataModel]()
        mores.append(addMore(icon: "recruitment.png", desc: getDesc(key: "recruitment")))
        mores.append(addMore(icon: "partners.png", desc: getDesc(key: "partners")))
        mores.append(addMore(icon: "introduction.png", desc: getDesc(key: "introduction")))
        mores.append(addMore(icon: "terms.png", desc: getDesc(key: "terms")))
        
        complention(mores)
    }
    func addMore(icon: String,desc: String)-> MoreDataModel{
        
        return MoreDataModel.init(icon: icon, desc: desc)
    }
    func getDesc(key: String) -> String {
        return LanguageManager.shared.localized(string: key)!
    }
    
}
