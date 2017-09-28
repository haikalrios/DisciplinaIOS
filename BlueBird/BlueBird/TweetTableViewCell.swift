//
//  TweetTableViewCell.swift
//  BlueBird
//
//  Created by Haikal Rios on 10/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    var tweet: Twitter.Tweet?{
        didSet{
            updateUI();
        }
    }
    
    private func updateUI(){
        postLabel?.text = tweet?.text
        titleLabel?.text = tweet?.user.description
        
        if let profileImageURL = tweet?.user.profileImageURL {
            if let imageData = try? Data(contentsOf: profileImageURL) {
                profileImageView?.image = UIImage(data: imageData)
            }
        }else {
            profileImageView?.image = nil
        }
        
        if let createdAt = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(createdAt) > 24*60*60 {
                formatter.dateStyle = .short
            }else {
                formatter.timeStyle = .short
            }
            userLabel?.text = formatter.string(from: createdAt)
        }else {
            userLabel?.text = nil
        }
    }
    

}
