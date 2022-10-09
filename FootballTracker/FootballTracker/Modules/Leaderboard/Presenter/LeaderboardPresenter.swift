//
//  LeaderboardPresenter.swift
//  FootballTracker
//
//  Created by Philip Boyko on 07.10.22.
//

import Foundation

protocol LeaderboardPresenterProtocol: AnyObject {
    func getPlayers()
    func backButtonTaped()
}

final class LeaderboardPresenter {

    // MARK: - Properties

    private weak var view: LeaderboardViewProtocol?
    private var players: [PlayerData] = []
    var filteredPlayers: [PlayerData] = []

    // MARK: - Public methods

    func backButtonTaped() {
        view?.closeVC()
    }

    func getPlayers() {
        players = playersPersistence.getPlayers()
        filteredPlayers = players
        view?.reloadTableView()
    }

    func filterPlayers(by type: LeaderboardFilterType) {
        switch type {
        case .wins:
            filteredPlayers = players.sorted(by: {$0.wins > $1.wins})
        case .games:
            filteredPlayers = players.sorted(by: {$0.games > $1.games})
        }
        view?.reloadTableView()
    }

    // MARK: - Init
    
    init(_ view: LeaderboardViewProtocol) {
      self.view = view
    }

    // MARK: - Private

    private var playersPersistence: PlayersPersistenceProviding {
        return lazyServicelocator.getService()
    }

}
