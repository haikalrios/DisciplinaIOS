//
//  FaceView.swift
//  Emoticon
//
//  Created by Pedro Henrique on 01/06/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    
    @IBInspectable
    var mouthCurvature: Double = 0.5 // 1.0 sorriso, -1.0 triste
    
    @IBInspectable
    var eyesOpen: Bool = true
    
    @IBInspectable
    var color: UIColor = UIColor.blue

    @IBInspectable
    var scale: CGFloat = 0.9
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0
    
    @IBInspectable
    var multiplyPi: CGFloat = 2
    
    private var skullRadius: CGFloat {
        return ((min(bounds.size.width , bounds.size.height) - lineWidth) / 2 ) * (scale / 100)
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter,
                                radius: skullRadius,
                                startAngle: 0,
                                endAngle: 2 * CGFloat.pi,
                                clockwise: false)
        path.lineWidth = lineWidth
        return path
    }
    
    
    private enum Eye {
        case left
        case right
    }
    
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        
        let path: UIBezierPath
        if (eyesOpen) {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius,
                                startAngle: 0, endAngle: CGFloat.pi * 2,
                                clockwise: false)
        }else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius,
                                  y: eyeCenter.y))
            
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius,
                                     y: eyeCenter.y))
        }
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth / 2,
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1)))
                            * mouthRect.height
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3,
                          y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3,
                          y: start.y + smileOffset)
        
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        
        path.lineWidth = lineWidth
        return path
        
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        color.setStroke()
        
        //circulo
        pathForSkull().stroke()
        
        
        //olho esquerdo
        pathForEye(.left).stroke()
        
        //olho direito
        pathForEye(.right).stroke()
        
        //boca
        pathForMouth().stroke()
        
    }
    

}
