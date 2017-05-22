//
//  ImagePlanVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 5/19/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class ImagePlanVC: BaseVC{
    
    let planImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "no_image"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var imgPlanString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "General"
    }
    override func viewWillAppear(_ animated: Bool) {
        planImage.loadImageUsingUrlString(urlString: self.imgPlanString!)
    }
    override func setupView() {
        super.setupView()
        self.view.addSubview(planImage)
        planImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        planImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        planImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        planImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}
