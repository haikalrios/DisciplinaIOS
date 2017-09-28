//
//  ViewController.swift
//  ExemploAula6
//
//  Created by Haikal Rios on 14/09/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var quadrado: UIView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(animarQuadrado(_:)))
            quadrado.addGestureRecognizer(tap)
        }
    }
    
    
    func animarQuadrado(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 5 ){ [unowned self] in
            var frame = self.quadrado.frame
            frame.origin =  CGPoint(x: 200, y : 200)
            self.quadrado.frame = frame
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(moverQuadrado(_:)))
        self.quadrado.addGestureRecognizer(tap)
    }
    
    func moverQuadrado(_ sender: UITapGestureRecognizer){
        //let destino = sender.location(in: self.view)
    }

}

