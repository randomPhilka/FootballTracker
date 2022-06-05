//
//  MatchesPresenter.swift
//  FootballTracker
//
//  Created by Philip Boyko on 2.06.22.
//

import Foundation

protocol MatchesPresenterProtocol: AnyObject {
    func addMatchButtonPressed()
}

final class MatchesPresenter: MatchesPresenterProtocol {

    // MARK: - Properties

    private weak var view: MatchesViewProtocol?
    var matches: [MatchData] = []
    
    // MARK: - Public methods

    func addMatchButtonPressed() {
        view?.presentAddMatchesVC()
    }
    
    func deleteMatch(buID id: String) {
        matchesPersistence.deleteMatch(buID: id) { error in
            guard error == nil else {
				#if DEBUG
                print("Failde to save locHistory to CoreData")
				#endif
                return
            }
        }
    }

    func getMatches() {
        matches = matchesPersistence.getMatches()
    }

    // MARK: - Init

    init(view: MatchesViewProtocol) {
        self.view = view
    }
    
    // MARK: - Private
    
    private var matchesPersistence: MatchesPersistenceProviding {
        return lazyServicelocator.getService()
    }

}
