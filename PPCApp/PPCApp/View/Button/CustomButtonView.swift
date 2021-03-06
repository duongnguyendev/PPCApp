//
//  CustomButtonView.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/25/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class RadioButtonView: BaseButton{
    var name: String?{
        didSet{
            nameLabelView.text = name
        }
    }
    var flag: Bool?{
        didSet{
            if flag == true{
                iconImageView.image = UIImage(named: "rdb_select.png")
            }else{
                iconImageView.image = UIImage(named: "rdb_noselect.png")
            }
        }
    }
    private let iconImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let nameLabelView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.textColor = UIColor.navigationBar()
        return label
    }()
    
    
    override func setupView() {
        super.setupView()
        addSubview(iconImageView)
        addSubview(nameLabelView)
        
        addConstraintWithFormat(format: "H:|[v0]-10-[v1]|", views: iconImageView, nameLabelView)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameLabelView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor, constant: 0).isActive = true
    }
    
}
class CheckBox: BaseButton {
    
    var name: String?{
        didSet{
            nameLabelView.text = name
        }
    }
    var flag: Bool?{
        didSet{
            if flag == true{
                iconImageView.image = UIImage(named: "ckb_select.png")
            }else{
                iconImageView.image = UIImage(named: "ckb_noselect.png")
            }
        }
    }
    private let iconImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let nameLabelView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.textColor = UIColor.navigationBar()
        return label
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(iconImageView)
        addSubview(nameLabelView)
        
        addConstraintWithFormat(format: "H:|[v0]-10-[v1]|", views: iconImageView, nameLabelView)
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        nameLabelView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor, constant: 0).isActive = true
    }
}

class ChoosePhoto: BaseButton {
    var bgrImage: UIImage!{
        didSet{
            bgrImageView.image = bgrImage
        }
    }
    var flag: Bool?{
        didSet{
            if flag == true{
                checkImageView.image = UIImage.fontAwesomeIcon(name: .checkCircle, textColor: UIColor.white, size: CGSize(width: 100, height: 100))
            }else{
                checkImageView.image = UIImage.fontAwesomeIcon(name: .circleO, textColor: UIColor.white, size: CGSize(width: 100, height: 100))
            }
        }
    }
    private let checkImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let bgrImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(bgrImageView)
        addSubview(checkImageView)
        
        addConstraintWithFormat(format: "H:[v0]|", views: checkImageView)
        addConstraintWithFormat(format: "V:|[v0]", views: checkImageView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: bgrImageView)
        addConstraintWithFormat(format: "V:|[v0]|", views: bgrImageView)
        checkImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        checkImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
