//
//  QuedaLivreBehavior.swift
//  JogoQuadradinho
//
//  Created by Haikal Rios on 14/09/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit

class QuedaLivreBehavior: UIDynamicBehavior {

    private var gravidade: UIGravityBehavior?
    private var colisao: UICollisionBehavior?
    

    override init() {
        super.init()
        
        gravidade = UIGravityBehavior()
        gravidade?.magnitude = 0.7
        
        colisao =  UICollisionBehavior()
        colisao?.translatesReferenceBoundsIntoBoundary = true
        
        addChildBehavior(gravidade!)
        addChildBehavior(colisao!)
        
        
    }

}
