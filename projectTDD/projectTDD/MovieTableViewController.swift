//
//  MovieTableViewController.swift
//  projectTDD
//
//  Created by Haikal Rios on 16/11/2017.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    let movies = Movie.loadMovies()


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return movies.count
    }

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return movies.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMovie", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.genere.description

        return cell
    }
 

   

}
