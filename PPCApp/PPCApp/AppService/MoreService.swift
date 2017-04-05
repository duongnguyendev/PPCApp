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
        mores.append(addMore(icon: "recruitment.png", desc: LanguageManager.shared.localized(string: "recruitment")!))
        mores.append(addMore(icon: "partners.png", desc: LanguageManager.shared.localized(string: "partners")!))
        mores.append(addMore(icon: "introduction.png", desc: LanguageManager.shared.localized(string: "about")!))
        mores.append(addMore(icon: "terms.png", desc: LanguageManager.shared.localized(string: "terms")!))
        mores.append(addMore(icon: "", desc: LanguageManager.shared.localized(string: "setting")!))
        mores.append(addMore(icon: "", desc:LanguageManager.shared.localized(string: "projectmanager")!))
        
        complention(mores)
    }
    func addMore(icon: String,desc: String)-> MoreDataModel{
        
        return MoreDataModel.init(icon: icon, desc: desc)
    }
    
}
