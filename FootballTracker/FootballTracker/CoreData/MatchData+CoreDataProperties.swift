//
//  MatchData+CoreDataProperties.swift
//  FootballTracker
//
//  Created by Philip Boyko on 07.10.22.
//
//

import Foundation
import CoreData


extension MatchData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatchData> {
        return NSFetchRequest<MatchData>(entityName: "MatchData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var scoreOne: Int64
    @NSManaged public var scoreTwo: Int64
    @NSManaged public var teamOne: String?
    @NSManaged public var teamTwo: String?

}

extension MatchData : Identifiable {

}
