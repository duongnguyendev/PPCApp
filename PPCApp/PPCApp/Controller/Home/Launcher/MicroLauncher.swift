//
//  MicroLauncher.swift
//  PPCApp
//
//  Created by Macbook Solution on 5/5/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
import Speech
class MicroLauncher: BaseLauncher {
       
    var microText: String?{
        didSet{
            microLabel.text = microText
        }
    }
    let microLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.textColor = UIColor.navigationBar()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buttonListen: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button

    }()
    lazy var microImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "micro")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override func setupContent() {
        self.height = windowFrame.size.height
        super.setupContent()
        microText = "I'm Listening!"
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: blackView.centerXAnchor, constant: 0).isActive = true
        contentView.centerYAnchor.constraint(equalTo: blackView.centerYAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(microImageView)
        contentView.addSubview(microLabel)
        
        microImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        microImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        microImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        microImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30).isActive = true
        
        microLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        microLabel.bottomAnchor.constraint(equalTo: microImageView.bottomAnchor, constant: 20).isActive = true
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
