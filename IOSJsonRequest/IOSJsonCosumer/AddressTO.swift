//
//  AddressTO.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 05/10/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit

struct AddressTO: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo : GeoLocTO
    
    init(street: String,
        suite: String,
        city: String,
        zipcode: String,
        geo: GeoLocTO) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
        
    }
    
    
}
