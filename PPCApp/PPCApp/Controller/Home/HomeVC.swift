//
//  HomeVC.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/20/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import Photos

class HomeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Home"
        let assets = PHAsset.fetchAssets(with: .image, options: nil)
        PHImageManager.default().requestImage(for: assets[0], targetSize: CGSize(width: 1000, height: 1000), contentMode: .default, options: nil, resultHandler: { (image, nil) in
            self.view.backgroundColor = UIColor.init(patternImage: image!)
        })

        view.backgroundColor = UIColor.blue
        title = "Home"
        // Do any additional setup after loading the view.
    }
}
