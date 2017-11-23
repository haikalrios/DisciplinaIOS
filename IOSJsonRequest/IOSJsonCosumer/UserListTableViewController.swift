//
//  UserListTableViewController.swift
//  IOSJsonCosumer
//
//  Created by HC5MAC12 on 21/09/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit
import SystemConfiguration
import CoreData



class UserListTableViewController: UITableViewController, URLSessionDataDelegate {
    
    @IBOutlet weak var tipoDado: UILabel!
    var dataReceived =  Data()
    var usersTO = [UserTO]()
    var userDAO: UserDAO = UserDAO()
    
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data){
        //Appenda data a medida que vai sendo recuperado
        dataReceived.append(data)
    }
    
   
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
       //finalizado o receved parseia o JSON
        let decoder = JSONDecoder()
        do {
            usersTO = try decoder.decode([UserTO].self, from: dataReceived)
            userDAO.salveUsers(usersTO: usersTO)
            DispatchQueue.main.async { [unowned self] in
                self.tipoDado.text = "On-Line, sincronizado"
                self.tableView.reloadData()
                
            }
        }catch 	{
            print(error)
            tipoDado.text = "erro no request, dados do BD Local"
            usersTO = userDAO.findAll()
            self.tableView.reloadData()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = usersTO[indexPath.row];
        performSegue(withIdentifier: "userDetail", sender: user);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Antes de fazer a requisição é necessário saber se existe conexão com a internet, caso não haja é necessário recuperar os dados do Banco de Dados CoreData
       // print(currentReachabilityStatus)
        if(currentReachabilityStatus != .notReachable){//true conectado
            
            requestUsers()
        }else{
            tipoDado.text = "off-line, dados do BD Local"
            usersTO = userDAO.findAll()
            self.tableView.reloadData()
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetail"{
            if let view = segue.destination as? ViewControllerDetailUser{
                if let userTO = sender as? UserTO{
                    view.user = userTO
                }
            }
        }
    }
    
   
    
    private func requestUsers(){
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.networkServiceType = .default
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.isDiscretionary = true
        config.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 1200, diskPath: NSTemporaryDirectory())
        
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        queue.maxConcurrentOperationCount = 5
        queue.underlyingQueue =  DispatchQueue.global()
        
        let session = URLSession(configuration: config,
                                 delegate: self,
                                 delegateQueue: queue)
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users"){
            var request = URLRequest(url: url)
            request.timeoutInterval = 10
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let dataTask = session.dataTask(with: request)
            dataTask.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }




    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersTO.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)
        let user = usersTO[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.username
    
        return cell
    }
  
   

}

protocol Utilities{
    
}

extension NSObject:Utilities{
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }


    var currentReachabilityStatus: ReachabilityStatus {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
    
}

