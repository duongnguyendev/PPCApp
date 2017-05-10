//
//  RecruitmentDetailVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/4/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class RecruitmentDetailVC: BaseVC {
    @IBOutlet weak var recruitmentImage: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    var recruitment = RecruitmentDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recruitment Detail"
    }
    override func viewWillAppear(_ animated: Bool) {
        self.infoRecruitment()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func infoRecruitment(){
        recruitmentImage.loadImageUsingUrlString(urlString: recruitment.image)
        titleLabel.text = recruitment.title
        deadlineLabel.text = "\(LanguageManager.shared.localized(string: "deadline")!) : \(recruitment.deadline)"
        recruitment.content.htmlAttributedString(completion: { (mString) in
            contentTextView.attributedText = mString
        })

    }
    
}
