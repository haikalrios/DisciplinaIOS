//
//  Tweet.swift
//  BlueBird
//
//  Created by Haikal Rios on 24/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import CoreData
import Twitter

class Tweet: NSManagedObject {
    
    static func findOrCreateTweet(matching twitterInfo: Twitter.Tweet, in context: NSManagedObjectContext) throws -> Tweet{
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.identifier)
        do{
            let matches = try context.fetch(request)
            if matches.count > 0{
                assert(matches.count == 1, "Incosistencia no banco de dados! Encontrado mais de um registro para o Identificador")
                return matches[0]
            }
        }catch{
            throw error
        }
        let tweet = Tweet(context: context)
        tweet.unique = twitterInfo.identifier
        tweet.text = twitterInfo.text
        tweet.created = twitterInfo.created as NSData
        do{
            tweet.tweeter = try TwitterUser.findOrCreateTwitterUser(matching: twitterInfo.user, in: context)
        }catch{
            throw error
        }
        return tweet
    }

}
