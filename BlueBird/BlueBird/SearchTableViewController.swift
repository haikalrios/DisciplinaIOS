//
//  SearchTableViewController.swift
//  BlueBird
//
//  Created by Haikal Rios on 10/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import Twitter


class SearchTableViewController: UITableViewController,  UITextFieldDelegate {

    private var tweets = [Array<Twitter.Tweet>]()
    

    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet {
            searchTextField.delegate = self
        }
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchText = textField.text
        }
        return true
    }
    
   
    var searchText: String?{
        didSet{
            searchTextField?.text = searchText
            searchTextField?.resignFirstResponder()
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if searchText == nil{
            searchText = "#trump"
        }
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    func insertTweets(_ newTweets: [Twitter.Tweet]){
        self.tweets.insert(newTweets, at: 0)
        self.tableView.insertSections([0], with: .fade)
    }
    
    private func searchForTweets(){
        if let text = searchText, !(text.isEmpty){
            let request = Twitter.Request(search: text, count: 100)
            request.fetchTweets{[weak self] newTweets in
                DispatchQueue.main.async{
                    self?.insertTweets(newTweets)
                }
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let tweet = tweets[indexPath.section][indexPath.row]
        
        if let celula = cell as? TweetTableViewCell{
           celula.tweet = tweet
        }

        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationController = segue.destination
       
        
        if let identifier = segue.identifier{
            if identifier == "showDetailTweet"{
                if let detailTableViewController = destionationController as? DetailTweetTableViewController,
                    let tweetTableCell = sender as? TweetTableViewCell {
   
                    detailTableViewController.tweet = tweetTableCell.tweet
                }
            }
            
        }

    }
  
}
