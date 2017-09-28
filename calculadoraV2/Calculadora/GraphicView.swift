//
//  GraficView.swift
//  Calculadora
//
//  Created by Haikal Rios on 11/07/17.
//  Copyright © 2017 IESB - Instituto de Educação Superior de Brasília. All rights reserved.
//

import UIKit


protocol GraphViewDataSource {
    func getY(x: CGFloat) -> CGFloat?
    func isRead() -> Bool
}

@IBDesignable
class GraphicView: UIView {

    //variavel que determina intervalo do pontos do eixo x para desenho
    let valueIncreseXForLoop: CGFloat = 4
   /*
    @IBInspectable
    var color: UIColor = UIColor.blue{
        didSet{
            setNeedsDisplay()
        }
    }*/
    
    //escala do grafico
    @IBInspectable
    var scale: CGFloat = 10{
        didSet{
            setNeedsDisplay()
        }
    }
 
    //cor de linha para os eixos x e Y
    @IBInspectable
    var colorLine: UIColor = UIColor.red {
        didSet { setNeedsDisplay() }
        
    }
    
    //determina as posiçoes dos eixos x e y na tela
    private var cord: CGPoint {
        get {
            var cord =  cordCenter
            cord.x += graficCenter.x
            cord.y += graficCenter.y
            return cord
        }
        set {
            var cord = newValue
            cord.x -= graficCenter.x
            cord.y -= graficCenter.y
            cordCenter = cord
        }

 
    }
    
    var  cordCenter = CGPoint.zero  { didSet { setNeedsDisplay() } } // Origem relativa ao centro
    
    private var graficCenter: CGPoint {
        return convert(center, from: superview)
    }
    
    //padrao datasource para comunicar com controle
    var dataSource: GraphViewDataSource?
   
   
    override func draw(_ rect: CGRect) {
        var axesDrawer = AxesDrawer()
        
        //cord = cord ?? CGPoint(x: bounds.midX, y: bounds.midY)
        
        axesDrawer.contentScaleFactor = contentScaleFactor
        axesDrawer.color = colorLine
        axesDrawer.drawAxes(in: bounds, origin: cord, pointsPerUnit: scale)
        
        if dataSource != nil && (dataSource?.isRead())!  {
            self.drawGraph()
        }

        
        
    }
    
      private func drawGraph()
    {
        UIGraphicsGetCurrentContext()!.saveGState()

        let bezierPath = UIBezierPath()
        var xInDrawMinToMax =  bounds.minX
        var firstPoint = true
        while xInDrawMinToMax <= bounds.maxX {

            let x = getX(xInDraw: xInDrawMinToMax)
            //busca o y no controle através do pathern datasource
            if let y = dataSource?.getY(x: x) {
               
                //garante valor valido
                if y.isNormal || y.isZero {
                    //trasforama em posicao relativa na tela
                    let yInDraw = getYInDraw(y: y)
                    //garante que esta no eixo visivel
                    if yInDraw <= bounds.maxY && yInDraw >= bounds.minY {
                        if firstPoint {
                            bezierPath.move(to: CGPoint(x: xInDrawMinToMax, y: yInDraw))
                            firstPoint = false
                        } else {
                            bezierPath.addLine(to: CGPoint(x: xInDrawMinToMax, y: yInDraw))
                        }
                    }
                }
             
            }
            xInDrawMinToMax += valueIncreseXForLoop
                    }
        bezierPath.stroke()
        UIGraphicsGetCurrentContext()!.restoreGState()
        
        
    }
    
    private func getX(xInDraw: CGFloat) -> CGFloat {
        return (xInDraw - cord.x) / scale
    }
    
    private func getYInDraw(y: CGFloat) -> CGFloat {
        return -((y * scale) - cord.y)
    }
    
    func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer){
        switch pinchRecognizer.state {
        case.changed, .ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    
    func move(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed: fallthrough
        case .ended:
            let translation = recognizer.translation(in: self)
  
            cord.x += translation.x
            cord.y += translation.y
            
            recognizer.setTranslation(CGPoint.zero, in: self)
        default: break
        }
    }
    

    func doubleTap(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            cord = recognizer.location(in: self)
        }
    }



}
