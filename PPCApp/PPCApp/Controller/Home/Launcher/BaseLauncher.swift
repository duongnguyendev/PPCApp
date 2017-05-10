//
//  BaseLauncher.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 4/4/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
class BaseLauncher: NSObject {
    var height : CGFloat = 100
    let windowFrame : CGRect = (UIApplication.shared.keyWindow?.frame)!
    let blackView = UIView()
    
    let contentView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init() {
        super.init()
        setupContent()
    }
    
    func setupContent(){
        if let window = UIApplication.shared.keyWindow{
            self.blackView.isHidden = true
            self.contentView.isHidden = true
            
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(contentView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
        }
    }
    func show(){
        self.blackView.isHidden = false
        self.contentView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
        }, completion: nil)
    }
    
    func close(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
        }) { (Bool) in
            self.blackView.isHidden = true
            self.contentView.isHidden = true
        }
    }
    
}
