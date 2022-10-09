//
//  AppDelegate.swift
//  FootballTracker
//
//  Created by Philip Boyko on 1.06.22.
//

import UIKit

var lazyServicelocator: LazyServiceLocator!

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        addServices()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        var coreDataPersistenceManager: CoreDataPersistenceManagerProviding {
            return lazyServicelocator.getService()
        }
        coreDataPersistenceManager.savePersistentContainer()
    }

    // MARK: - Private functions

    private func addServices() {
        lazyServicelocator = LazyServiceLocator()

        // MARK: - CoreData
        lazyServicelocator.addService(CoreDataPersistenceManagerProvider() as CoreDataPersistenceManagerProviding)
        lazyServicelocator.addService(MatchesPersistenceProvider() as MatchesPersistenceProviding)
        lazyServicelocator.addService(PlayersPersistenceProvider() as PlayersPersistenceProviding)
		// MARK: - Validation
        lazyServicelocator.addService(ValidationServiceProvider() as ValidationServiceProviding)

        serviceLocator = lazyServicelocator
    }

}

