//
//  ServiceLocator.swift
//  FootballTracker
//
//  Created by Philip Boyko on 1.06.22.
//

import Foundation

protocol ServiceLocator {
    func getService<T>(_: T.Type) -> T
    func getService<T>() -> T
}

extension ServiceLocator {
    func getService<T>() -> T {
        return getService(T.self)
    }
}

var serviceLocator: ServiceLocator!

func application<T>(_ type: T.Type = T.self) -> T {
    serviceLocator.getService(type)
}

final class LazyServiceLocator: ServiceLocator {

    enum RegistryRecord {
        case recipe(() -> Any)
        case instance(Any)
    }

    // MARK: - Public

    func addService<T>(_ recipe: @escaping () -> T) {
        let key = getName(T.self)
        registryService[key] = .recipe(recipe)
    }

    func addService<T>(_ instance: T) {
        let key = getName(T.self)
        registryService[key] = .instance(instance)
    }

    func getService<T>(_: T.Type) -> T {
        let instanceToFind: T?
        if let registryRecord = registryService[getName(T.self)] {
            switch registryRecord {
            case .instance(let _instance):
                instanceToFind = _instance as? T
            case .recipe(let recipe):
                instanceToFind = recipe() as? T
                if let instance = instanceToFind {
                    addService(instance)
                }
            }
        } else {
            fatalError("No found service \(getName(T.self))")
        }
        return instanceToFind!
    }

    // MARK: - Private

    private lazy var registryService: [String: RegistryRecord] = [:]

    private func getName(_ someType: Any) -> String {
        return (someType is Any.Type) ? "\(someType)" : "\(type(of: someType))"
    }

}
