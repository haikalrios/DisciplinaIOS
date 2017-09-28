//
//  DetailTweetTableViewController.swift
//  BlueBird
//
//  Created by Haikal Rios on 13/08/17.
//  Copyright © 2017 Haikal Rios. All rights reserved.
//

import UIKit
import Twitter

class DetailTweetTableViewController: UITableViewController {

    private var mentionSections = [MentionSection]()
    var tweet: Twitter.Tweet? {
        didSet{
            guard let tweet = tweet else { return }
            title = tweet.user.screenName
            populaMetionSections()
            
        }

    }
    
    
    private struct MentionSection {
        var type: String
        var mentions: [MentionItem]
    }
    
    private enum MentionItem {
        case mention(Twitter.Mention)
        case image(MediaItem)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
     
    }
    
    private func populaMetionSections() {
        
        if (tweet?.media.count)! > 0 {
            mentionSections.append(MentionSection(type: "Imagens", mentions: (tweet?.media.map{ MentionItem.image($0)})!))
        
        }
        if (tweet?.urls.count)! > 0 {
            mentionSections.append(MentionSection(type: "Urls", mentions: (tweet?.urls.map{ MentionItem.mention($0)})!))
        }
        if (tweet?.userMentions.count)! > 0 {
            mentionSections.append(MentionSection(type: "Usuarios", mentions: (tweet?.userMentions.map{ MentionItem.mention($0)})!))
        }
        if (tweet?.hashtags.count)! > 0 {
            mentionSections.append(MentionSection(type: "Hashtags", mentions: (tweet?.hashtags.map{ MentionItem.mention($0)})!))
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mentionSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return mentionSections[section].mentions.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let elemetMention = mentionSections[indexPath.section].mentions[indexPath.row]

        switch elemetMention {
        case .mention(let mention):
            let cell = tableView.dequeueReusableCell(withIdentifier: "mention", for: indexPath)
            if let mentionCell = cell as? MentionTableViewCell {
                mentionCell.mention = mention
            }

            return cell
        case .image(let image):
            let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath)
            if let imageCell = cell as? ImageTableViewCell {
                imageCell.imageItem = image
            }
            return cell
        }
        

        
       
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return mentionSections[section].type
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "searchAgain" {
                if let searchDestination = segue.destination as? SearchTableViewController,
                    let cell = sender as? MentionTableViewCell,
                    var text = cell.textLabel?.text {
                    if text.hasPrefix("@") {text += " OR from:" + text} 
                    searchDestination.searchText = text
                    
                }
            
            }
        }

    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    
            if identifier == "searchAgain" {
                if let cell = sender as? MentionTableViewCell,
                    let text = cell.textLabel?.text {
                    if text.hasPrefix("@") || text.hasPrefix("#") {
                        return true
                    }
                }
                
            }
        return false
        

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let mention = mentionSections[indexPath.section].mentions[indexPath.row]
        switch mention {
        case .image(let mediaItem):
            return tableView.bounds.size.width / CGFloat(mediaItem.aspectRatio)
        default:
            return UITableViewAutomaticDimension
        }

    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
