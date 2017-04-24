//
//  SpeechLauncher.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/21/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class SpeechLauncher: BaseLauncher {
    
    let buttonImage : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        button.setTitle("Close", for: .normal)
        
        return button
    }()
    
    override func setupContent() {
        super.setupContent()
        contentView.frame = windowFrame
        contentView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        contentView.addSubview(buttonImage)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: buttonImage)
        contentView.addConstraintWithFormat(format: "V:|-64-[v0]-64-|", views: buttonImage)
    }
    
    override func close() {
        super.close()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0
        }) { (Bool) in
            
        }
    }
    override func show() {
        super.show()
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 1
        }) { (Bool) in
            
        }
    }
}
