//
//  Triangle.swift
//  Emoticon
//
//  Created by Haikal Rios on 08/06/17.
//  Copyright © 2017 IESB. All rights reserved.
//


import UIKit

@IBDesignable
class Triangle: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0
    
    @IBInspectable
    var color: UIColor = UIColor.blue
    
    @IBInspectable
    var scale: CGFloat = 0.9
    
  

    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
    
        path.move(to: CGPoint(x: bounds.midX , y: 0))
        path.addLine(to: CGPoint(x: (bounds.midX * 2) - lineWidth,y: (bounds.midY * 2) - lineWidth))
        path.addLine(to: CGPoint(x: 0,y: (bounds.midY * 2) - lineWidth))

        path.close()
        UIColor.green.setFill()
        UIColor.red.setStroke()
        path.lineWidth = lineWidth
        path.fill()
        path.stroke()
    }
}

