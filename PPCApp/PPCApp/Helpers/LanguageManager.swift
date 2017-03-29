//
//  LanguageManager.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class Language: NSObject {
    var language : String?
    var languageCode : String?
    
    init(languageCode: String, language: String) {
        self.languageCode = languageCode
        self.language = language
    }
}
class LanguageManager: NSObject {
    static let shared = LanguageManager()
    var bundle : Bundle?
    override init() {
        super.init()
        let languageCode = self.getCurrentLanguage().languageCode
        let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        bundle = Bundle(path: bundlePath!)
    }
    func localized(string: String) -> String?{
        
        return NSLocalizedString(string, bundle: bundle!, comment: "")
    }
    func setCurrent(language : Language){
        UserDefaults.standard.set([language.languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        let bundlePath = Bundle.main.path(forResource: language.languageCode, ofType: "lproj")
        bundle = Bundle(path: bundlePath!)
    }
    
    func getCurrentLanguage() -> Language {
        let languageCode = Locale.preferredLanguages[0]
        var language : Language?
        if languageCode == "vi" || languageCode == "vi-VN"{
            language = Language(languageCode: "vi", language: "Tiếng Việt")
        }else{
            language = Language(languageCode: "en", language: "English")
        }
        return language!
    }
}
