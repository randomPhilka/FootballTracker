//
//  AddMatchPresenter.swift
//  FootballTracker
//
//  Created by Philip Boyko on 3.06.22.
//

import Foundation

protocol AddMatchPresenterProtocol: AnyObject {
    func saveMatch(name: String?, teamOne: String?, teamTwo: String?)
    func updateScore(_ score: Int, forTeam: Team)
    func backButtonTaped()
}

final class AddMatchPresenter {

    // MARK: - Properties

    private weak var view: AddMatchViewProtocol?
    private var scores: Scores

    // MARK: - Public methods

    func saveMatch(name: String?, teamOne: String?, teamTwo: String?) {
        do {
            let isValid  = try validationService.validateMatch(name: name, teamOne: teamOne, teamTwo: teamTwo)
            guard isValid else { return }

            let match = Match(id: UUID().uuidString,
                              name: name,
                              scoreOne: scores.teamOne,
                              scoreTwo: scores.teamTwo,
                              teamOne: teamOne,
                              teamTwo: teamTwo)
            let firstPlayer = Player(name: teamOne ?? "", winCurrentGame: scores.teamOne > scores.teamTwo)
            let secondPlayer = Player(name: teamTwo ?? "", winCurrentGame: scores.teamTwo > scores.teamOne)

            matchesPersistence.addMatch(match) { [weak self] error in
                guard error == nil else { return }
                self?.playersPersistence.updatePlayer(firstPlayer) { error in
                    guard error == nil else { return }
                    self?.playersPersistence.updatePlayer(secondPlayer) { error in
                        guard error == nil else { return }
                        DispatchQueue.main.async {
                            self?.view?.presentAlert(title: localize("addMatch.matchSaved"), message: "") { _ in
                                self?.view?.closeVC()
                            }
                        }
                    }
                }
            }
        } catch let error as ValidationError {
            view?.presentAlert(title: localize("addMatch.error"), message: error.failureReason ?? "", handler: nil)
        } catch {
            view?.presentAlert(title: localize("addMatch.error"), message: localize("addMatch.errorDescription"), handler: nil)
        }

    }

    func updateScore(_ score: Int, forTeam: Team) {
        switch forTeam {
        case .one:
            scores.teamOne = score
            view?.setScore(scores.teamOne, forTeam: .one)
        case .two:
            scores.teamTwo = score
            view?.setScore(scores.teamTwo, forTeam: .two)
        }
    }

    func backButtonTaped() {
        view?.closeVC()
    }

    // MARK: - Init
    
    init(
      _ view: AddMatchViewProtocol,
      initialState: Scores = .init(teamOne: 0, teamTwo: 0)
    ) {
      self.view = view
      self.scores = initialState
    }

    // MARK: - Private

    private var matchesPersistence: MatchesPersistenceProviding {
        return lazyServicelocator.getService()
    }
    private var playersPersistence: PlayersPersistenceProviding {
        return lazyServicelocator.getService()
    }
    private var validationService: ValidationServiceProviding {
        return lazyServicelocator.getService()
    }

}
