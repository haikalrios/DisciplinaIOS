//
//  ViewController.swift
//  JogoQuadradinho
//
//  Created by Haikal Rios on 14/09/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabuleiro: UIView!
    
    @IBOutlet weak var limpar: UIButton!
    
    @IBAction func addQuadrado(_ sender: Any) {
        var frame = CGRect(origin: CGPoint.zero, size: gerarTamanhoAleatorio())
        let x = (arc4random() % UInt32(tabuleiro.bounds.size.width))
        frame.origin.x =  CGFloat(x) * frame.size.width
        
        let quadradinho = UIView(frame : frame)
        quadradinho.backgroundColor = gerarCor()
        
        tabuleiro.addSubview(quadradinho)
        
        
    }
    
    private func gerarTamanhoAleatorio() -> CGSize {
        let aresta = CGFloat(arc4random() % 100)
        return CGSize(width: aresta, height: aresta)
    }
    
    private func gerarCor() -> UIColor{
        switch arc4random() % 6 {
        case 0:
            return UIColor.red
        case 1:
            return UIColor.blue
        case 2:
            return UIColor.yellow
        case 3:
            return UIColor.green
        case 4:
            return UIColor.black
        case 5:
            return UIColor.purple
        default:
            return UIColor.magenta
        }
    }

}

