//
//  MatchesViewController.swift
//  FootballTracker
//
//  Created by Philip Boyko on 2.06.22.
//

import UIKit

protocol MatchesViewProtocol: AnyObject {
    func presentAddMatchesVC()
    func presentLeaderboardVC()
}

final class MatchesViewController: DefaultViewController {

    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Actions

    @IBAction func addMatchButtonTaped(_ sender: Any) {
        matchesPresenter.addMatchButtonPressed()
    }
    @IBAction func leaderboardButtonTaped(_ sender: Any) {
        matchesPresenter.leaderboardButtonPressed()
    }
    
    // MARK: - Properties

    lazy var matchesPresenter = MatchesPresenter(view: self)

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        matchesPresenter.getMatches()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // resize dynamic cells
        tableView.reloadData()
    }

    override func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupLocalization() {
        titleLabel.text = localize("matches.titleLabel")
    }

    // MARK: - Private methods

    private func setupTableView() {
        tableView.register(UINib.init(nibName: MatchTableViewCell.id, bundle: nil), forCellReuseIdentifier: MatchTableViewCell.id)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }

}

// MARK: - UITableViewDataSource

extension MatchesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesPresenter.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.id, for: indexPath) as? MatchTableViewCell else { fatalError() }
        cell.update(with: matchesPresenter.matches[safe: indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension MatchesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: localize("matches.delete")) { [weak self] (_,_,_) in
            guard let self = self else { return }
            self.matchesPresenter.deleteMatch(self.matchesPresenter.matches[safe: indexPath.row]) { [weak self] error in
                guard error == nil else {
                    #if DEBUG
                    print("Failed to delete match from CoreData - \(error?.localizedDescription ?? "")")
                    #endif
                    self?.showAlert(title: localize("matches.error"), message: localize("matches.errorDescription"), handler: nil)
                    return
                }
                self?.matchesPresenter.matches.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
}

// MARK: - MatchesViewProtocol

extension MatchesViewController: MatchesViewProtocol {

    func presentAddMatchesVC() {
        push(controller: .addMatch, fromStory: .addMatch)
    }

    func presentLeaderboardVC() {
        pushFromRightToLeft(controller: .leaderboard, fromStory: .leaderboard)
    }

}
