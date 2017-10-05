//
//  UserTO.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 28/09/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit

struct UserTO: Codable {
    var id: Int32
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var address: AddressTO
    var company: CompanyTO
    
    init(id: Int32,
         name: String,
         username: String,
         email: String,
         phone: String,
         website: String,
         address: AddressTO,
         company: CompanyTO) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
        
    }
}
