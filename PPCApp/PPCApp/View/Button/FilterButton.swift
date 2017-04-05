//
//  FilterButton.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 4/3/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FilterButton: BaseButton {

    
    var value : String?{
        didSet{
            self.valueLableView.text = value
        }
    }
    
    var title : String?{
        didSet{
            self.titleLabelView.text = title
        }
    }
    
    private let titleLabelView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        return label
        
    }()
    private let valueLableView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.textAlignment = .right
        return label
        
    }()
    private let arrowImageView : UIImageView = {
        let iv = UIImageView(image: UIImage.fontAwesomeIcon(name: .angleDown, textColor: UIColor.gray, size: CGSize(width: 20, height: 20), backgroundColor: UIColor.clear))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    override func setupView() {
        backgroundColor = UIColor.white
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        
        addSubview(titleLabelView)
        addSubview(valueLableView)
        addSubview(arrowImageView)
        
        addConstraintWithFormat(format: "H:|-20-[v0(120)][v1]-10-[v2(30)]|", views: titleLabelView, valueLableView, arrowImageView)
        
        addConstraintWithFormat(format: "V:|[v0]|", views: titleLabelView)
        addConstraintWithFormat(format: "V:|[v0]|", views: valueLableView)
        addConstraintWithFormat(format: "V:|[v0]|", views: arrowImageView)
        
    }

}
