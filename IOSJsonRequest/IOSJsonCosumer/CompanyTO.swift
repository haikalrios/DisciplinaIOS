//
//  CompanyTO.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 05/10/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit

struct CompanyTO: Codable {
    var name: String
    var catchPhrase: String
    var bs: String
    
    init(name: String,
         catchPhrase: String,
         bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
