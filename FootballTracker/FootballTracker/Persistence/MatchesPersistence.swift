//
//  MatchesPersistence.swift
//  FootballTracker
//
//  Created by Philip Boyko on 2.06.22.
//

import Foundation
import CoreData

protocol MatchesPersistenceProviding {
    func addMatch(_ match: Match, _ complition: @escaping (Error?) -> Void)
    func deleteMatch(buID id: String, _ complition: @escaping (Error?) -> Void)
    func getMatches() -> [MatchData]
}

final class MatchesPersistenceProvider: MatchesPersistenceProviding {

    lazy var context: NSManagedObjectContext = {
        return coreDataPersistenceManager.persistentContainer.viewContext
    }()

    // MARK: - Public methods

    func addMatch(_ match: Match, _ complition: @escaping (Error?) -> Void) {
        coreDataPersistenceManager.persistentContainer.performBackgroundTask { [weak self] context in
            guard let self = self else { return }
            if let matchData = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: context) as? MatchData {
                matchData.id = match.id
                matchData.name = match.name
                matchData.teamOne = match.teamOne
                matchData.teamTwo = match.teamTwo
                matchData.scoreOne = Int64(match.scoreOne)
                matchData.scoreTwo = Int64(match.scoreTwo)
            }
            do {
                try context.save()
                complition(nil)
            } catch {
                complition(error)
            }
        }
    }
    
    func deleteMatch(buID id: String, _ complition: @escaping (Error?) -> Void) {
        if let matchData = getMatchData(byID: id) {
            context.delete(matchData)
            do {
                try context.save()
                complition(nil)
            } catch {
                complition(error)
            }
        }
    }
    
    func getMatches() -> [MatchData] {
        do {
           return try context.fetch(NSFetchRequest(entityName: entityName))
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    // MARK: - Private
    
    private var entityName = "MatchData"
    
    private func getMatchData(byID id: String) -> MatchData? {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            guard let arg = (\MatchData.id)._kvcKeyPathString else { return nil }
            request.predicate = NSPredicate(format: "%K == %@", arg, id)
            return try context.fetch(request).first as? MatchData
        } catch {
			#if DEBUG
            print("Failed to get MatchData, \(error)")
			#endif
            return nil
        }
    }
    
    private var coreDataPersistenceManager: CoreDataPersistenceManagerProviding {
        return lazyServicelocator.getService()
    }

}
