//
//  DetailNewVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/11/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class NewDetailVC: BaseVC{
    
    @IBOutlet weak var webView: UIWebView!
    var new = NewDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //titleLabel.numberOfLines = 2
    }
    override func viewDidAppear(_ animated: Bool) {
        title = new.title
        webView.loadHTMLString(new.content, baseURL: nil)
    }
    
}
