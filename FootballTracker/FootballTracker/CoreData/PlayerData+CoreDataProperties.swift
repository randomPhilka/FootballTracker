//
//  PlayerData+CoreDataProperties.swift
//  FootballTracker
//
//  Created by Philip Boyko on 07.10.22.
//
//

import Foundation
import CoreData


extension PlayerData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerData> {
        return NSFetchRequest<PlayerData>(entityName: "PlayerData")
    }

    @NSManaged public var games: Int64
    @NSManaged public var name: String?
    @NSManaged public var wins: Int64

}

extension PlayerData : Identifiable {

}
