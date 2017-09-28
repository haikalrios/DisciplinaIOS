//
//  FaceView.swift
//  aula4
//
//  Created by Haikal Rios on 01/06/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView : UIView{
    
    @IBInspectable
    var color: UIColor = UIColor.blue
    
   
    @IBInspectable
    var scale: CGFloat = 0.0001
    
    private enum Eye{
        case left
        case right
    }
    
    private struct Radius{
        static let skullRadiusToEyeOffset:   CGFloat = 3
        static let skullRadiusToEyeRadius:   CGFloat = 10
        static let skullRadiusToMouthWidth:  CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }
    
    private var skullCenter: CGPoint{
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var skullRadius: CGFloat {
        return (min(bounds.size.width, bounds.size.height)/2) - scale
    }
    
    private func pathForSkull() -> UIBezierPath{
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius,
                                startAngle: 0,
                                endAngle: 2 * CGFloat.pi,
                                clockwise: false)
        return path
    }
    
    
    override func draw(_ rect: CGRect) {
        color.setStroke()
        
        pathForSkull().addLine(to: skullCenter)
        pathForSkull().stroke()
    }

}
