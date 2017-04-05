//
//  AboutVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/4/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class AboutVC: BaseVC {
    
    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About PPC"
    }
    override func viewDidAppear(_ animated: Bool) {
        
        aboutTextView.text = LanguageManager.shared.localized(string: "about_desc")
    }
}
