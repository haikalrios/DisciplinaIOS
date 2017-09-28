//
//  GraphicViewController.swift
//  Calculadora
//
//  Created by Haikal Rios on 11/07/17.
//  Copyright © 2017 IESB - Instituto de Educação Superior de Brasília. All rights reserved.
//

import UIKit

class GraphicViewController: UIViewController, GraphViewDataSource {
    
    func getY( x: CGFloat) -> CGFloat? {
        if let function = calculatorFunctionUnary{
            return CGFloat(function(Double(x))!)
            
        }
        return x
       
    }
    
    func isRead() -> Bool{
        return calculatorFunctionUnary != nil
    }
    
    public var calculatorFunctionUnary: ((Double) -> Double?)? = nil

    @IBOutlet var graphicView: GraphicView!{
        didSet {
            //Estabelece canal comunicação da view com a controller
            graphicView.dataSource = self
            
            graphicView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphicView, action: #selector(GraphicView.changeScale(byReactingTo:))))
            
            graphicView.addGestureRecognizer(UIPanGestureRecognizer(target: graphicView, action: #selector(graphicView.move(_:))))
            
  
            let recognizer = UITapGestureRecognizer(target: graphicView, action: #selector(graphicView.doubleTap(_:)))
            recognizer.numberOfTapsRequired = 2
            graphicView.addGestureRecognizer(recognizer)
        }
    }
    
 
}
