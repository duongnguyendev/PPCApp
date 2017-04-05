//
//  ImageDetailLauncher.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 4/4/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class ImageDetailLauncher: BaseLauncher {
    
    let buttonClose : UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        button.setTitle("Close", for: .normal)
        
        return button
    }()
    
    override func setupContent() {
        self.height = windowFrame.size.height
        buttonClose.addTarget(self, action: #selector(handleCloseButton(_:)), for: .touchUpInside )
        super.setupContent()
        contentView.frame = windowFrame
        contentView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        contentView.addSubview(buttonClose)
        contentView.addConstraintWithFormat(format: "H:|[v0(60)]", views: buttonClose)
        contentView.addConstraintWithFormat(format: "V:|-20-[v0(30)]", views: buttonClose)
        
    }
    
    func handleCloseButton(_ sender: UIButton){
        self.close()
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
