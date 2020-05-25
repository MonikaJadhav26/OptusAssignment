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
  
  
  //1
  static let sharedManager = CoreDataManager()
  private init() {} // Prevent clients from creating another instance.
  
  //2
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "CityTemperature")
    
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  //3
  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  var cityList = Array<City>()

  /*Insert*/
  func insertCity(name: String, id : Int , temperature : Double)  {
    
    if !checkRecordForSelectedIdIsExists(id: id)  {
    
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "City",
                                            in: managedContext)!
    
    let newCity = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // Initialize Fetch Request
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    //Add Predicate
    let predicate = NSPredicate(format: "(id = %d)", id)
    fetchRequest.entity = entity
    fetchRequest.predicate = predicate
    
        // Populate City
            newCity.setValue(name, forKey: "name")
            newCity.setValue(id, forKey: "id")
            newCity.setValue(temperature, forKey: "temperature")
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
       
       // Initialize Fetch Request
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
       //Add Predicate
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
    /*Before you can do anything with Core Data, you need a managed object context. */
    let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
    
    // Create Entity Description
    let entityDescription = NSEntityDescription.entity(forEntityName: "City", in: managedContext)
    
    // Configure Fetch Request
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
