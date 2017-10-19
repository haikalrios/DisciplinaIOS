//
//  FormTableViewController.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 11/10/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit
import CoreData

class FormTableViewController: UITableViewController {

    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldSite: UITextField!
    @IBOutlet weak var textFieldEndereco: UITextField!
    @IBOutlet weak var textFieldComplemento: UITextField!
    @IBOutlet weak var textFieldCidade: UITextField!
    @IBOutlet weak var textFieldNomeEmpresa: UITextField!
    @IBOutlet weak var textFieldDescricao: UITextField!
    @IBOutlet weak var textFieldAtividade: UITextField!
    @IBOutlet weak var textFieldCep: UITextField!
    @IBOutlet weak var textFieldLatitude: UITextField!
    @IBOutlet weak var textFieldLongitude: UITextField!
    
    var context = AppDelegate.viewContext
    var dataReceived =  Data()
    var userDAO: UserDAO = UserDAO()
    var session: URLSession!
    
    @IBAction func fecharForm(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func salvarUsuario(_ sender: Any) {

        
        let companyTO = CompanyTO(name: textFieldEndereco.text!,
                                  catchPhrase: textFieldNomeEmpresa.text!,
                                  bs: textFieldAtividade.text!)
        let geoLocTO = GeoLocTO(lat: textFieldLatitude.text!, lng: textFieldLongitude.text!)
        
        let addressTO = AddressTO(street: textFieldEndereco.text!,
                                 suite: textFieldComplemento.text!,
                                 city: textFieldCidade.text!,
                                 zipcode: textFieldCep.text!,
                                 geo: geoLocTO)
        let userTO = UserTO(id: 1,
                            name: textFieldNome.text!,
                            username: textFieldLogin.text!,
                            email: textFieldEmail.text!,
                            phone: textFieldTelefone.text!,
                            website: textFieldSite.text!,
                            address: addressTO,
                            company: companyTO)
        var usersTO = [UserTO]()
        usersTO.append(userTO)
        userDAO.salveUsers(usersTO: usersTO)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do{
            let data = try encoder.encode(userTO)
            let json = String(data: data, encoding: .utf8)
            let jsonData = json?.data(using: .utf8)
            let url = URL(string: "https://jsonplaceholder.typicode.com/users")
            var request = URLRequest(url: url!)
            request.timeoutInterval = 5
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "post"
            request.httpBody = jsonData
            let task = session.dataTask(with: request)
            task.resume()
            
        }catch{
            debugPrint(error)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        session = URLSession(configuration: config,
                                 delegate: self,
                                 delegateQueue: queue)
        
        textFieldLogin.delegate = self
        textFieldCep.delegate = self
        textFieldNome.delegate = self
        textFieldSite.delegate = self
        textFieldEmail.delegate = self
        textFieldCidade.delegate = self
        textFieldEndereco.delegate = self
        textFieldTelefone.delegate = self
        textFieldAtividade.delegate = self
        textFieldDescricao.delegate = self
        textFieldComplemento.delegate = self
        textFieldNomeEmpresa.delegate = self
        textFieldLatitude.delegate =  self
        textFieldLongitude.delegate =  self
      
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }




}

extension FormTableViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text?.isEmpty)!{
            textField.backgroundColor = UIColor.red
        }else{
           textField.backgroundColor = UIColor.white
        }
    }
    
}


extension FormTableViewController: URLSessionDataDelegate{
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data){
        dataReceived.append(data);
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error != nil{
            print(error)
        }
    }
}
