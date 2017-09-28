//
//  PersistentSearch.swift
//  BlueBird
//
//  Created by Haikal Rios on 24/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class PersistentSearch: SearchTableViewController {
    
    private var container:  NSPersistentContainer? = AppDelegate.persistentContainer
    
    override func insertTweets(_ newTweets: [Twitter.Tweet]) {
        super.insertTweets(newTweets)
        updateDatabase(with: newTweets)
    }
    
    private func updateDatabase(with tweets: [Twitter.Tweet]){
        container?.performBackgroundTask{context in
            for twitterinfo in tweets{
                _ = try? Tweet.findOrCreateTweet(matching: twitterinfo, in: context)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if identifier == "twitters"{
                if let tableController = segue.destination as? TwitterTableViewController{
                    tableController.searchText = search
                }
            }
        }
    }
}
