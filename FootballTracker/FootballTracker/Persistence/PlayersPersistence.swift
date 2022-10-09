//
//  PlayersPersistence.swift
//  FootballTracker
//
//  Created by Philip Boyko on 08.10.22.
//

import Foundation
import CoreData

protocol PlayersPersistenceProviding {
    func updatePlayer(_ player: Player, _ complition: @escaping (Error?) -> Void)
    func deeltePlayer(_ player: Player, _ complition: @escaping (Error?) -> Void)
    func getPlayers() -> [PlayerData] 
}

final class PlayersPersistenceProvider: PlayersPersistenceProviding {

    lazy var context: NSManagedObjectContext = {
        return coreDataPersistenceManager.persistentContainer.viewContext
    }()

    // MARK: - Public methods

    func updatePlayer(_ player: Player, _ complition: @escaping (Error?) -> Void) {
        if let personData = getPlayerData(byName: player.name) {
            personData.wins += player.winCurrentGame ? 1 : 0
            personData.games += 1
            do {
                try context.save()
                complition(nil)
            } catch {
                complition(error)
            }
        } else {
            coreDataPersistenceManager.persistentContainer.performBackgroundTask { [weak self] context in
                guard let self = self else { return }
                if let playerData = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: context) as? PlayerData {
                    playerData.name = player.name
                    playerData.wins = player.winCurrentGame ? 1 : 0
                    playerData.games = 1
                }
                do {
                    try context.save()
                    complition(nil)
                } catch {
                    complition(error)
                }
            }
        }
    }

    func deeltePlayer(_ player: Player, _ complition: @escaping (Error?) -> Void) {
        guard  let personData = getPlayerData(byName: player.name) else { return complition(nil) }
        if personData.games <= 1 {
            context.delete(personData)
        } else {
            personData.wins -= player.winCurrentGame ? 1 : 0
            personData.games -= 1
        }
        do {
            try context.save()
            complition(nil)
        } catch {
            complition(error)
        }
    }

    
    func getPlayers() -> [PlayerData] {
        do {
           return try context.fetch(NSFetchRequest(entityName: entityName))
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    // MARK: - Private
    
    private var entityName = "PlayerData"
    
    private func getPlayerData(byName: String) -> PlayerData? {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            guard let arg = (\PlayerData.name)._kvcKeyPathString else { return nil }
            request.predicate = NSPredicate(format: "%K == %@", arg, byName)
            return try context.fetch(request).first as? PlayerData
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
