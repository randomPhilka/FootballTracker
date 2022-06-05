//
//  MatchData+CoreDataProperties.swift
//  FootballTracker
//
//  Created by Philip Boyko on 5.06.22.
//
//

import Foundation
import CoreData


extension MatchData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatchData> {
        return NSFetchRequest<MatchData>(entityName: "MatchData")
    }

    @NSManaged public var teamTwo: String?
    @NSManaged public var teamOne: String?
    @NSManaged public var scoreOne: Int64
    @NSManaged public var scoreTwo: Int64
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var id: String?

}

extension MatchData : Identifiable {

}
