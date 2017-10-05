//
//  UserDAO.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 28/09/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit
import CoreData

struct UserDAO {
    
    var context = AppDelegate.viewContext
    
    
    mutating func findAll() -> [UserTO]{
        var usersTO = [UserTO]()
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        let order = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [order]
        do{
            if let usersRecuparada = try context?.fetch(fetchRequest){
                usersTO = usersToUsersTO(users: usersRecuparada)
            }
            
        }catch let erro{
          print("Erro ao recuperar usuários: \(erro.localizedDescription)")
        }
        return usersTO
    }
    
    func salveUsers(usersTO: [UserTO] )  {
         _ = usersTOToUsers(usersTO: usersTO)
         do {
            if(context!.hasChanges){
                try context!.save()
                print("Sucesso ao salvar usuário(s)!")
            }
        } catch let erro {
            print("Erro ao salvar usuário: \(erro.localizedDescription)")
        }
    }
    
    
    func getUserById(id:Int32) -> User?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //Aplicar filtros por id
        let predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.predicate = predicate
        
        do{
            if let user = try context?.fetch(fetchRequest) {
                if user.count > 0{
                    return (user[0] as! User)
                }
                
            }
        }catch let erro{
            print("Erro ao pesquisar usuário: \(erro.localizedDescription)")
        }
        return nil
    }
    
    private func usersToUsersTO(users: [User]) -> [UserTO]{
        var usersTORetorno = [UserTO]()
        
        if users.count > 0{
            for user in users{
                var companyTO : CompanyTO? = nil
                var addressTO : AddressTO? = nil
                
                if let company = user.company{
                    companyTO = companyToCompanyTO(company: company)
                }
               
                if let address = user.address{
                    addressTO = addressToAddressTO(address: address)
                }
                
                let userTO = UserTO(id: user.id,
                                    name: user.name!,
                                    username: user.userName!,
                                    email: user.email!,
                                    phone: user.phone!,
                                    website: user.webSite!,
                                    address: addressTO!,
                                    company: companyTO!)
                usersTORetorno.append(userTO)
            }
        }
        return usersTORetorno
    }
    
    private func companyToCompanyTO(company: Company) -> CompanyTO{
        
        let companyTO = CompanyTO(name: company.name!,
                                catchPhrase: company.catchPhrase!,
                                bs: company.bs!)
        return companyTO
    }
    
    private func addressToAddressTO(address: Address) -> AddressTO{
        let geoLocTO = geoLocToGeoLocTO(geoLoc: address.geo!)
        let address = AddressTO(street: address.street!,
                              suite: address.suite!,
                              city: address.city!,
                              zipcode: address.zipcode!,
                              geo: geoLocTO)
        return address
    }
    
    private func geoLocToGeoLocTO(geoLoc: GeoLoc) -> GeoLocTO{
        
        let geoLocTO = GeoLocTO(lat: geoLoc.lat!, lng : geoLoc.lng!)
        return geoLocTO
    }
    

    
    private func usersTOToUsers(usersTO: [UserTO]) -> [User]{
        var usersRetorno = [User]()
        
        if usersTO.count > 0{
            for userTO in usersTO {
                let user = getUserById(id: userTO.id) ?? User(context: context!)
               
                let company = user.company ?? Company(context: context!)
                company.bs = userTO.company.bs
                company.catchPhrase = userTO.company.catchPhrase
                company.name = userTO.company.name
                
                let address = user.address ?? Address(context: context!)
                let geoLoc = address.geo ?? GeoLoc(context: context!)
                
                geoLoc.lat = userTO.address.geo.lat
                geoLoc.lng = userTO.address.geo.lng
                
                address.city = userTO.address.city
                address.geo =  geoLoc
                address.street = userTO.address.street
                address.suite = userTO.address.suite
                address.zipcode = userTO.address.zipcode
                
               
                user.id = userTO.id
                user.name = userTO.name
                user.userName = userTO.username
                user.webSite = userTO.website
                user.phone = userTO.phone
                user.email = userTO.email
                user.company = company
                user.address = address
                    
                
                usersRetorno.append(user)
            }
        }
        return usersRetorno
    }

}
