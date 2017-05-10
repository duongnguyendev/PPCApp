//
//  TermsCell.swift
//  PPCApp
//
//  Created by NguoiNb on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class TermsCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    var term:TermsModel!{
        didSet{
            title.text =  term.title
            content.text = term.content
        }
    }
}
