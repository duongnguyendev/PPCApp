//
//  PostCell.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class PostCell: BaseCell {
    
    var posterImageView : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "vinpearl"))
        return iv
    }()
    let lableName : UILabel = {
        let label = UILabel()
        label.text = "Home City"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        return label
    }()
    let lableAddress : UILabel = {
        let label = UILabel()
        label.text = "537 Nguyen Duy Trinh, District 2, Ho Chi Minh City"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        return label
    }()
    let labelAcreage : UILabel = {
        let label = UILabel()
        label.text = "5370 m2"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        return label
    }()
    let iconHome : UIImageView = {
        let homeIcon = UIImage.fontAwesomeIcon(name: .home, textColor: UIColor.navigationBar(), size: CGSize(width: 30, height: 30))
        let iv = UIImageView(image: homeIcon)
        iv.contentMode = .scaleAspectFill
        //        iv.backgroundColor = UIColor.brown
        return iv
    }()
    
    override func setupView() {
        self.backgroundColor = UIColor.white
        addSubview(posterImageView)
        addSubview(lableName)
        addSubview(lableAddress)
        addSubview(iconHome)
        addSubview(labelAcreage)
        
        let posterHeight = frame.size.width / 16 * 9
        
        posterImageView.heightAnchor.constraint(equalToConstant: posterHeight).isActive = true
        
        addConstraintWithFormat(format: "V:|[v0]-5-[v1(20)]-5-[v2(20)][v3(25)]", views: posterImageView, lableName, lableAddress,  iconHome)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: posterImageView)
        addConstraintWithFormat(format: "H:|-10-[v0]-20-|", views: lableName)
        addConstraintWithFormat(format: "H:|-10-[v0]-20-|", views: lableAddress)
        addConstraintWithFormat(format: "H:|-7-[v0(25)]-5-[v1]-10-|", views: iconHome, labelAcreage )
        
        labelAcreage.centerYAnchor.constraint(equalTo: iconHome.centerYAnchor, constant: 0).isActive = true
        labelAcreage.heightAnchor.constraint(equalTo: iconHome.heightAnchor, multiplier: 1).isActive = true
    }
    
    var home: HomeDataModel?{
        didSet{
            self.posterImageView.loadImageUsingUrlString(urlString: (home?.image)!)
            self.lableName.text = home?.title
            self.lableAddress.text = home?.address
            let acreage = ((home?.acreage)?.description)! + " m2"
            self.labelAcreage.text = acreage
        }
    }
}
