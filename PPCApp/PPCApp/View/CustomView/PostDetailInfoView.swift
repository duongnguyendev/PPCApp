//
//  PostDetailInfoView.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/29/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        
    }
}

class PostDetailInfoView: BaseView {
    var title : String?{
        didSet{
            labelTitle.text = title
        }
    }
    var content : String?{
        didSet{
            textViewContent.text = content
        }
    }
    let labelTitle : UILabel = {
        let lablel = UILabel()
        lablel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightMedium)
        lablel.textColor = UIColor.navigationBar()
        return lablel
    }()
    let textViewContent : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        
        addSubview(labelTitle)
        addSubview(textViewContent)
        addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: labelTitle)
        addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: textViewContent)
        addConstraintWithFormat(format: "V:|-10-[v0(15)]-(\(-5))-[v1]|", views: labelTitle, textViewContent)
    }
}

class GeneralButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    func setupView() {
        let iconImage = UIImageView(image: UIImage.fontAwesomeIcon(name: .image, textColor: UIColor.navigationBar(), size: CGSize(width: 100, height: 100)))
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        let rightArrowImage = UIImageView(image: UIImage.fontAwesomeIcon(name: .angleRight, textColor: UIColor.lightGray, size: CGSize(width: 100, height: 100)))
        rightArrowImage.translatesAutoresizingMaskIntoConstraints = false
        let labelTitle = UILabel()
        labelTitle.text = "General Layout"
        labelTitle.textColor = UIColor.navigationBar()
        addSubview(iconImage)
        addSubview(labelTitle)
        addSubview(rightArrowImage)
        
        addConstraintWithFormat(format: "H:|-18-[v0(30)]-5-[v1][v2(30)]|", views: iconImage, labelTitle, rightArrowImage)
        
        addConstraintWithFormat(format: "V:|-10-[v0]-10-|", views: iconImage)
        
        labelTitle.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor, constant: 0).isActive = true
        rightArrowImage.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor, constant: 0).isActive = true
        rightArrowImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class GeneralPost: BaseButton {
    var name: String?{
        didSet{
            nameLabel.text = name
        }
    }
    let nameLabel: UILabel = {
        let lablel = UILabel()
        lablel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        lablel.textColor = UIColor.navigationBar()
        return lablel
    }()
    
    override func setupView() {
        super.setupView()
        let rightArrowImage = UIImageView(image: UIImage.fontAwesomeIcon(name: .angleRight, textColor: UIColor.lightGray, size: CGSize(width: 100, height: 100)))
        rightArrowImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(nameLabel)
        addSubview(rightArrowImage)
        
        addConstraintWithFormat(format: "H:|-10-[v0]-10-[v1(30)]|", views: nameLabel,rightArrowImage)
        addConstraintWithFormat(format: "V:|-10-[v0]-10-|", views: nameLabel)
        
        rightArrowImage.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 0).isActive = true
        rightArrowImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
