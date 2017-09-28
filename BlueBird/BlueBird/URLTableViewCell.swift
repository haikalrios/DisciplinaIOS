//
//  URLTableViewCell.swift
//  BlueBird
//
//  Created by Haikal Rios on 13/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import Twitter

class URLTableViewCell: MentionTableViewCell {

    @IBOutlet weak var labelurl: UILabel!

    
    override public func updateUI(){
        labelurl.text = mention?.keyword
    }
}
