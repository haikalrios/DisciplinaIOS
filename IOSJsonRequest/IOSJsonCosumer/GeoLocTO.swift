//
//  GeoLocTO.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 05/10/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit

struct GeoLocTO: Codable {
    var lat: String
    var lng: String
    
    init(lat: String, lng : String) {
        self.lat = lat
        self.lng = lng
    }
}
