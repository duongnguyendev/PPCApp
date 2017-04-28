//
//  PhotoCell.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/27/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
@objc protocol PhotoVCDelegate {
    @objc optional func selected(sender: ChoosePhoto)
}
class PhotoCell: BaseCell {
    var count: Int = 0
    var delegate: PhotoVCDelegate?
    var images = [UIImage]()
    let buttonPhoto: ChoosePhoto = {
       let button = ChoosePhoto()
        button.isSelected = false
        button.bgrImage = UIImage(named: "vinpearl")
        button.flag = false
        return button
    }()
    override func setupView() {
        super.setupView()
        addSubview(buttonPhoto)
        buttonPhoto.addTarget(self, action: #selector(handleChooseButton(_:)), for: .touchUpInside)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: buttonPhoto)
        addConstraintWithFormat(format: "V:|[v0]|", views: buttonPhoto)
    }
    func handleChooseButton(_ sender: ChoosePhoto){
        if self.delegate != nil{
            if sender.isSelected{
                sender.isSelected = false
                sender.flag = false
            }else{
                sender.isSelected = true
                sender.flag = true
            }
            self.delegate?.selected!(sender: sender)
        }
      
    }
}
