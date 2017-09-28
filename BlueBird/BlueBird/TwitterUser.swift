//
//  TwitterUser.swift
//  BlueBird
//
//  Created by Haikal Rios on 24/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import CoreData
import Twitter


class TwitterUser: NSManagedObject {
    
    static func findOrCreateTwitterUser(matching twitterInfo: Twitter.User, in context: NSManagedObjectContext) throws -> TwitterUser{
        let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.screenName)
        
        do{
            let matches = try context.fetch(request)
            if matches.count > 0{
                assert(matches.count == 1, "Incosistencia no banco de dados! Encontrado mais de um registro para o Identificador")
                return matches[0]
            }

        }catch{
            throw error
        }
        let twitterUser = TwitterUser(context: context)
        twitterUser.handle = twitterInfo.id
        twitterUser.name = twitterInfo.name
        return twitterUser
    }


}
