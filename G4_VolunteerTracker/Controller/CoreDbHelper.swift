//
//  CoreDbHelper.swift
//  G4_VolunteerTracker
//
//  Created by som on 21/05/22.
//

import Foundation
import CoreData
import UIKit

class CoreDbHelper{
    //coreDbHelper Singleton
    private static var shared : CoreDbHelper?
    
    private let moc : NSManagedObjectContext
    private let USER_ENTITY_NAME = "User"

    //MARK: init
    private init(context : NSManagedObjectContext){
        self.moc = context
    }
    
    //MARK: Helpers
    static func getInstance() -> CoreDbHelper{
        //returns instance of coreDb singleton
        if shared == nil{
            //initialize the object
            shared = CoreDbHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
        return shared!
    }
  
    func createUser(name: String, email: String, password: String){
        //helper method for placing a new user
        do{
            
            let userToCreate = NSEntityDescription.insertNewObject(forEntityName: USER_ENTITY_NAME, into: self.moc) as! User

            userToCreate.name = name
            userToCreate.email = email
            userToCreate.password = password
            
            if self.moc.hasChanges{
                try self.moc.save()
                
                print(#function, "User is saved successfully into CoreData")
                print("Email: \(email), Password: \(password)")
            }
            
        } catch let error as NSError{
            print(#function, "Could not save the user \(error)")
        }
    }
    func getAllUsers() -> [User]?{
        let fetchRequest = NSFetchRequest<User>(entityName: USER_ENTITY_NAME)
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "Fetched Data : \(result as [User])")
            
            return result as [User]
            
        }catch let error as NSError{
            print(#function, "Could not fetch the data \(error)")
        }
        return nil
    }
    func searchUser(email : String) -> User?{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: USER_ENTITY_NAME)
        let predicateID = NSPredicate(format: "email == %@", email as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            
            let result = try self.moc.fetch(fetchRequest)
            
            if result.count > 0{
                print(#function, "Matching object found")
                return result.first as? User
            }
            
        }catch let error as NSError{
            print(#function, "Unable to search for user \(error)")
        }
        
        return nil
    }
}

