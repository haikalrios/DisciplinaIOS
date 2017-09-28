//
//  UserTO.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 28/09/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit

class UserTO: Codable {
    var id: Int16
    var name: String
    var username: String
    
    init(id: Int16,
         name: String,
         username: String) {
        self.id = id
        self.name = name
        self.username = username
        
    }
}
