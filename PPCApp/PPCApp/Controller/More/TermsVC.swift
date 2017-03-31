//
//  TermsVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/28/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class TermsVC: BaseVC {
    
    @IBOutlet weak var useTermsLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Terms"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        let useTerms = LanguageManager.shared.localized(string: "use_terms")
        let descTerms = LanguageManager.shared.localized(string: "desc_terms")
        useTermsLabel.text = useTerms
        descTextView.text = descTerms
    }

}
