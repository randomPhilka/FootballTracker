//
//  MatchesPresenter.swift
//  FootballTracker
//
//  Created by Philip Boyko on 2.06.22.
//

import Foundation

protocol MatchesPresenterProtocol: AnyObject {
    func addMatchButtonPressed()
    func leaderboardButtonPressed()
}

final class MatchesPresenter: MatchesPresenterProtocol {

    // MARK: - Properties

    private weak var view: MatchesViewProtocol?
    var matches: [MatchData] = []
    
    // MARK: - Public methods

    func addMatchButtonPressed() {
        view?.presentAddMatchesVC()
    }

    func leaderboardButtonPressed() {
        view?.presentLeaderboardVC()
    }
    
    func deleteMatch(_ match: MatchData?, _ complition: @escaping (Error?) -> Void) {
        guard let match = match else { return complition(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty match"])) }
        let firstPlayer = Player(name: match.teamOne ?? "", winCurrentGame: match.scoreOne > match.scoreTwo)
        let secondPlayer = Player(name: match.teamTwo ?? "", winCurrentGame: match.scoreTwo > match.scoreOne)

        matchesPersistence.deleteMatch(buID: match.id ?? "") { [weak self] error in
            guard error == nil else { return complition(error) }
            self?.playersPersistence.deeltePlayer(firstPlayer) { error in
                guard error == nil else { return complition(error) }
                self?.playersPersistence.deeltePlayer(secondPlayer) { error in
                    guard error == nil else { return complition(error) }
                    complition(nil)
                }
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
    private var playersPersistence: PlayersPersistenceProviding {
        return lazyServicelocator.getService()
    }

}
