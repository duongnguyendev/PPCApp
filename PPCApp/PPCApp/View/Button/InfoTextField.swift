//
//  InfoTextField.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/25/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//


import Foundation
import UIKit
class BaseTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    func setupView(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InfoTextField: BaseTextField {
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        
        //let textFieldContent = UITextField()
        self.textAlignment = NSTextAlignment.left
        self.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        self.textColor = UIColor.navigationBar()
        
    }
    
}

