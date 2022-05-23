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
    private let EVENT_ENTITY_NAME = "Event"
    private let VOLUNTEER_ENTITY_NAME = "Volunteer"

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
  
    // Create Operations
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
    
    func createEvent(name: String, info: String, organization: String, location: String, date: Date, start_time: Date, end_time: Date) {
        do {
            let eventToCreate = NSEntityDescription.insertNewObject(forEntityName: EVENT_ENTITY_NAME, into: self.moc) as! Event
        
            eventToCreate.name = name
            eventToCreate.info = info
            eventToCreate.organization = organization
            eventToCreate.location = location
            eventToCreate.date = date
            eventToCreate.start_time = start_time
            eventToCreate.end_time = end_time
            eventToCreate.id = UUID()
        
            if (self.moc.hasChanges) {
                try self.moc.save()
                print(#function, "Event is saved successfully into CoreData")
            }
        } catch let error as NSError {
            print(#function, "Could not save the event \(error)")
        }
    }
    
    func createVolunteer(user: User, event: Event) {
        do {
            let volunteerToCreate = NSEntityDescription.insertNewObject(forEntityName: VOLUNTEER_ENTITY_NAME, into: self.moc) as! Volunteer
            
            volunteerToCreate.user = user
            volunteerToCreate.event = event
            volunteerToCreate.attend = false
            volunteerToCreate.hours = 0.0
            volunteerToCreate.location = nil
            volunteerToCreate.picture = nil
            volunteerToCreate.id = UUID()
            
            if (self.moc.hasChanges) {
                try self.moc.save()
                print(#function, "Volunteer is saved successfully into CoreData")
            }
        } catch let error as NSError {
            print(#function, "Could not save the volunteer \(error)")
        }
    }
    
    // Read Operations
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
    
    func getAllEvents() -> [Event]? {
        let fetchRequest = NSFetchRequest<Event>(entityName: EVENT_ENTITY_NAME)
        do {
            let result = try self.moc.fetch(fetchRequest)
            print (#function, "Fetched Data : \(result as [Event])")
            return result as [Event]
        } catch let error as NSError {
            print(#function, "Could not fetch the data \(error)")
        }
        return nil
    }
    
    func getAllRelatedVolunteers(user: User) -> [Volunteer]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: VOLUNTEER_ENTITY_NAME)
        let predicateID = NSPredicate(format: "user == %@", user as CVarArg)
        fetchRequest.predicate = predicateID
        do {
            let result = try self.moc.fetch(fetchRequest)
            if (result.count > 0) {
                print(#function, "Matching objects found")
                return result as? [Volunteer]
            }
        } catch let error as NSError {
            print(#function, "Unable to search for user \(error)")
        }
        return nil
    }
    
    // Read Operations (specific)
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
    
    func searchEvent(eventID: UUID) -> Event? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EVENT_ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", eventID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do {
            let result = try self.moc.fetch(fetchRequest)
            if (result.count > 0) {
                print(#function, "Matching object found")
                return result.first as? Event
            }
        } catch let error as NSError {
            print(#function, "Unable to search for event \(error)")
        }
        return nil
    }
    
    func searchVolunteer(volunteerID: UUID) -> Volunteer? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: VOLUNTEER_ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", volunteerID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do {
            let result = try self.moc.fetch(fetchRequest)
            if (result.count > 0) {
                print(#function, "Matching object found")
                return result.first as? Volunteer
            }
        } catch let error as NSError {
            print(#function, "Unable to search for volunteer \(error)")
        }
        return nil
    }
    
    // Update Operations
    func updateVolunteer(updatedVolunteer: Volunteer) {
        let searchResult = self.searchVolunteer(volunteerID: updatedVolunteer.id! as UUID)
        if (searchResult != nil) {
            do {
                let volunteerToUpdate = searchResult!
                
                volunteerToUpdate.attend = true
                volunteerToUpdate.hours = updatedVolunteer.hours
                volunteerToUpdate.location = updatedVolunteer.location
                volunteerToUpdate.picture = updatedVolunteer.picture
                
                try self.moc.save()
                print(#function, "Volunteer updated successfully")
            } catch let error as NSError {
                print(#function, "Could not update the volunteer \(error)")
            }
        } else {
            print(#function, "No matching record found")
        }
    }
}

