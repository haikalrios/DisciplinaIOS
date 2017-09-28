//
//  TwitterTableViewController.swift
//  BlueBird
//
//  Created by Haikal Rios on 24/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import CoreData

class TwitterTableViewController: UITableViewController {
    var search : String?{
        didSet{
            updateUI()
        }
    }
    
    var container: NSPersistentContainer? = AppDelegate.persistentContainer{
        didSet{
            updateUI()
        }
    }
   
    fileprivate var fetchedResultController: NSFetchedResultsController<TwitterUser>
    
    private func updateUI(){
        if let context = container?.viewContext, sear
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cellUser", for: indexPath)
        return cell
    }
}

extension TwitterTableViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContet(_ controller: NSFetchedResultsControllerDelegate<NSFetchRequestResult>){
        tableView.beginUpdates()
    }
}
