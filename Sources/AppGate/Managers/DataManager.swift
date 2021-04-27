//
//  DataManager.swift
//  
//
//  Created by Diego Giraldo Gómez on 25/04/21.
//

import Foundation
import CoreData

enum Entities: String {
    case UserValidation
}

enum UserValidationKeys: String {
    case username
    case date
    case status
}

class DataManager {
    
    lazy var persistentContainer: NSPersistentContainer? = {
        guard let modelURL = Bundle.module.url(forResource: "AppGate", withExtension: "momd") else { return  nil }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
        let container = NSPersistentContainer(name: "AppGate", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext? = {
        let managedContext = self.persistentContainer?.viewContext
        return managedContext
    }()
    
    func saveValidation(validation: Validation){
        guard let managedContext = managedContext else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: Entities.UserValidation.rawValue, in: managedContext) else { return }
        let userValidation = NSManagedObject(entity: entity, insertInto: managedContext)
        
        userValidation.setValue(validation.username, forKey: UserValidationKeys.username.rawValue)
        userValidation.setValue(validation.date, forKey: UserValidationKeys.date.rawValue)
        userValidation.setValue(validation.status, forKey: UserValidationKeys.status.rawValue)
        
        do {
            try managedContext.save()
        } catch let error {
            print("Error setting validations: \(error.localizedDescription)")
        }
    }
    
    func getValidations(_ username: String) -> [UserValidation]? {
        guard let managedContext = managedContext else { return nil }
        let fReq: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.UserValidation.rawValue)
        fReq.predicate = NSPredicate(format: "username contains[c] %@", username)
        fReq.returnsObjectsAsFaults = false
        do {
            let result : [Any] = try managedContext.fetch(fReq)
            guard let parsedResult = result as? [UserValidation] else {
                print("Error parsing validations")
                return nil
            }
            return parsedResult
        } catch let error {
            print("Error getting validations: \(error.localizedDescription)")
            return nil
        }
    }
}
