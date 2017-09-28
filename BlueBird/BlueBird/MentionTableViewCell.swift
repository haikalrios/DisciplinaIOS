//
//  MentionTableViewCell.swift
//  BlueBird
//
//  Created by Haikal Rios on 15/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import Twitter

class MentionTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMention: UILabel!
    var mention: Twitter.Mention?{
        didSet{
            updateUI()
        }
    }

    public func updateUI(){
        textLabel?.text = mention?.keyword
               
    }
}
