//
//  UserDAO.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 28/09/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit
import CoreData

class UserDAO: NSObject {
    
    var context: NSManagedObjectContext!
    
    
    override init(){
        //CoreData: Recuperar o context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func findAll() -> [UserTO]{
        var usersTO = [UserTO]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let order = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [order]
        do{
            let usersRecuparada = try self.context.fetch(fetchRequest) as! [User]
            usersTO = usersToUsersTO(users: usersRecuparada)
        }catch let erro{
          print("Erro ao recuperar usuários: \(erro.localizedDescription)")
        }
        return usersTO
    }
    
    func salveUsers(usersTO: [UserTO] )  {
        _ = usersTOToUsers(usersTO: usersTO)
        do {
            if(context.hasChanges){
                try context.save()
                print("Sucesso ao salvar usuário(s)!")
            }
        } catch let erro {
            print("Erro ao salvar usuário: \(erro.localizedDescription)")
        }
    }
    
    private func usersToUsersTO(users: [User]) -> [UserTO]{
        var usersTORetorno = [UserTO]()
        
        if users.count > 0{
            for user in users as [NSManagedObject]{
                let userTO = UserTO(id: user.value(forKey: "id") as! Int16,
                                    name: user.value(forKey: "name") as! String,
                                    username: user.value(forKey: "userName") as! String)
                usersTORetorno.append(userTO)
            }
        }
        return usersTORetorno
    }
    
    private func usersTOToUsers(usersTO: [UserTO]) -> [User]{
        var usersRetorno = [User]()
        
        if usersTO.count > 0{
            
            for userTO in usersTO {
                let user = User(context: context)
                user.id = userTO.id
                user.name = userTO.name
                user.userName = userTO.username
                
                usersRetorno.append(user)
            }
        }
        return usersRetorno
    }

}
