//
//  InitialCities+CoreDataProperties.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 24/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//
//

import Foundation
import CoreData


extension InitialCities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InitialCities> {
        return NSFetchRequest<InitialCities>(entityName: "InitialCities")
    }

    @NSManaged public var isLoaded: Bool

}
