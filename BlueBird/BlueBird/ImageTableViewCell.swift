//
//  ImageTableViewCell.swift
//  BlueBird
//
//  Created by Haikal Rios on 15/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import Twitter

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var outletImage: UIImageView!
    
    var imageItem: Twitter.MediaItem? {
        didSet {updateUI()}
    }
    
    private func updateUI(){
       // textLabel?.text = imageItem?.description
        if let tweetImageURL = imageItem?.url{
            if let imageData = try? Data(contentsOf: tweetImageURL) {
                outletImage?.image = UIImage(data: imageData)
            }
        }else {
            outletImage?.image = nil
        }
        

    }

    

}
