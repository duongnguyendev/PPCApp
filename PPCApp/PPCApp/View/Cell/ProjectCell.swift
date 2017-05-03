//
//  PMCell.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/5/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
@objc protocol ProjectVCDelegate {
    @objc optional func selected(project : HomeDataModel)
    @objc optional func deleted(project : HomeDataModel)
}
class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var generalImage: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeProjectLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var delegate: ProjectVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //deleteButton.layer.borderWidth = 2.0
        editButton.backgroundColor = UIColor.navigationBar()
        deleteButton.layer.borderColor = UIColor.navigationBar().cgColor
    }
    
    var project: HomeDataModel?{
        didSet{
            generalImage.loadImageUsingUrlString(urlString: (project?.image)!)
            titleLabel.text = project?.title
            typeProjectLabel.text = project?.project
            statusLabel.text = self.statusProject(status: (project?.status)!)
        }
    }
    func statusProject(status: Int)->String{
        if status == 0{
            return "Not Approve"
        }
        return "Approve"
    }
    
    @IBAction func handleEdit(_ sender: Any) {
        
    }
    @IBAction func handleDelete(_ sender: Any) {
        if delegate != nil{
            delegate?.deleted!(project: project!)
        }

    }

    
}
