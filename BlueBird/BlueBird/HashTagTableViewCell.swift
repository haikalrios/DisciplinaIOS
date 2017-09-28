//
//  HashTagTableViewCell.swift
//  BlueBird
//
//  Created by Haikal Rios on 13/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import Twitter

class HashTagTableViewCell: MentionTableViewCell {

    @IBOutlet weak var labelHashTag: UILabel!
    
    
    override public func updateUI(){
       labelHashTag.text = mention?.keyword
    }
  }
