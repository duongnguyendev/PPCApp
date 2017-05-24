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
    @objc optional func edit(project : HomeDataModel)
    @objc optional func remove(project : HomeDataModel)
    
}
class ProjectCell: UITableViewCell {
    
    @IBOutlet weak var generalImage: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeProjectLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var typeofproject: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var manipulation: UILabel!
    
    var delegate: ProjectVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.backgroundColor = UIColor.navigationBar()
        deleteButton.layer.borderColor = UIColor.navigationBar().cgColor
        title.text = LanguageManager.shared.localized(string: "title")! + ":"
        typeofproject.text = LanguageManager.shared.localized(string: "typeofproject")! + ":"
        status.text = LanguageManager.shared.localized(string: "status")! + ":"
        manipulation.text = LanguageManager.shared.localized(string: "manipulation")! + ":"
        editButton.setTitle(LanguageManager.shared.localized(string: "edit"), for: .normal)
        deleteButton.setTitle(LanguageManager.shared.localized(string: "delete"), for: .normal)
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
            return LanguageManager.shared.localized(string: "not_approved")!
        }
        return LanguageManager.shared.localized(string: "approved")!
    }
    
    @IBAction func handleEdit(_ sender: Any) {
        if delegate != nil{
            delegate?.edit!(project: project!)
        }
    }
    @IBAction func handleDelete(_ sender: Any) {
        if delegate != nil{
            delegate?.remove!(project: project!)
        }
    }
    
    
}
