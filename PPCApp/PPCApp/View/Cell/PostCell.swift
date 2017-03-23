//
//  PostCell.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class PostCell: BaseCell {
    
    let posterImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.blue
//        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let lableName : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let lableAddress : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let labelAcreage : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let iconHome : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.brown
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override func setupView() {
        addSubview(posterImageView)
        addSubview(lableName)
        addSubview(lableAddress)
        addSubview(iconHome)
        addSubview(labelAcreage)
        
        let posterHeight = frame.size.width / 16 * 9
        
        posterImageView.heightAnchor.constraint(equalToConstant: posterHeight).isActive = true
        
        addConstraintWithFormat(format: "V:|[v0]-10-[v1(20)]-10-[v2(20)]-10-[v3(20)]", views: posterImageView, lableName, lableAddress,  iconHome)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: posterImageView)
        addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: lableName)
        addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: lableAddress)
        addConstraintWithFormat(format: "H:|-20-[v0(20)]-10-[v1]-20-|", views: iconHome, labelAcreage )
        
        labelAcreage.centerYAnchor.constraint(equalTo: iconHome.centerYAnchor, constant: 0).isActive = true
        labelAcreage.heightAnchor.constraint(equalTo: iconHome.heightAnchor, multiplier: 1).isActive = true
    }

}
