//
//  ViewController.swift
//  Emoticon
//
//  Created by Pedro Henrique on 01/06/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var triangle: Triangle!
    
    @IBOutlet var faceView: FaceView!
    
    @IBAction func changeEyes(_ sender: UISwitch) {
        faceView.eyesOpen = sender.isOn
        faceView.setNeedsDisplay()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        	super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}

