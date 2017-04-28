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
    
    @IBOutlet weak var recruitmentImage: UIImageView!
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var deadlinelbl: UILabel!
    
    
    @IBOutlet weak var contenttextView: UITextView!
    var objectRecruiment:RecruitmentDataModel = RecruitmentDataModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recruitment Detail"
        print("dddddd\(objectRecruiment.content)")
        set()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func set(){
        recruitmentImage.loadImageurl(link: objectRecruiment.image)
        titlelbl.text = objectRecruiment.title
        deadlinelbl.text = objectRecruiment.deadline
        
        contenttextView.text = objectRecruiment.content
       // print("aaaaa\(objectRecruiment.image)")
    }
    
}
