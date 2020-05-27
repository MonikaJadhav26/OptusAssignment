//
//  City+CoreDataProperties.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 22/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//
//

import Foundation
import CoreData


extension City {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var temperature: Double
    @NSManaged public var id: Int64
    @NSManaged public var currentTime: Int64
    @NSManaged public var timeZone: Int64
    
}
