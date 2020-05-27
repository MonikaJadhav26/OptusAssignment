//
//  CoreDataManager.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 25/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    
    //MARK: - Core Data Stack
    static let sharedManager = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CityTemperature")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var cityList = Array<City>()
    
    //MARK: - Methods for performing operations on database
    func insertCity(name: String, id : Int , temperature : Double , currentTime : Int , timezone : Int)  {
        
        if !checkRecordForSelectedIdIsExists(id: id)  {
            
            let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "City",
                                                    in: managedContext)!
            
            let newCity = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            
            let predicate = NSPredicate(format: "(id = %d)", id)
            fetchRequest.entity = entity
            fetchRequest.predicate = predicate
            
            newCity.setValue(name, forKey: "name")
            newCity.setValue(id, forKey: "id")
            newCity.setValue(temperature, forKey: "temperature")
            newCity.setValue(currentTime, forKey: "currentTime")
            newCity.setValue(timezone, forKey: "timeZone")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func checkRecordForSelectedIdIsExists(id : Int) -> Bool {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "City",
                                                in: managedContext)!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let predicate = NSPredicate(format: "(id = %d)", id)
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        do {
            let result = try managedContext.fetch(fetchRequest)
            if (result.count > 0) {
                let city = (result[0] as! NSManagedObject) as! City
                if city.id == id {
                    return true
                }
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return false
    }
    
    func fetchAllCities() -> Array<City> {
        
        cityList.removeAll()
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
        let entityDescription = NSEntityDescription.entity(forEntityName: "City", in: managedContext)
        
        fetchRequest.entity = entityDescription
        do {
            let result = try managedContext.fetch(fetchRequest)
            if (result.count > 0) {
                for city in result {
                    cityList.append(city as! City)
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return cityList
    }
    
}
