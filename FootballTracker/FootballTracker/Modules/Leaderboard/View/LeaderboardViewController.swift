//
//  LeaderboardViewController.swift
//  FootballTracker
//
//  Created by Philip Boyko on 07.10.22.
//

import UIKit

protocol LeaderboardViewProtocol: AnyObject {
    func closeVC()
    func reloadTableView()
}

final class LeaderboardViewController: DefaultViewController {

    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterSegmentControl: UISegmentedControl!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
   
    // MARK: - Actions

    @IBAction func backButtonTaped(_ sender: Any) {
        leaderboardPresenter.backButtonTaped()
    }
    @IBAction func filterSegmentControlTapped(_ sender: Any) {
        leaderboardPresenter.filterPlayers(by: LeaderboardFilterType.init(rawValue: filterSegmentControl.selectedSegmentIndex) ?? .wins)
    }

    // MARK: - Properties

    lazy var leaderboardPresenter = LeaderboardPresenter(self)

    // MARK: - Overrides

    override func setupUI() {
        setupTableView()
        leaderboardPresenter.getPlayers()
        leaderboardPresenter.filterPlayers(by: LeaderboardFilterType.init(rawValue: filterSegmentControl.selectedSegmentIndex) ?? .wins)
        bottomView.setupBorder(cornerRadius: 30, corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
    }

    override func setupDelegates() {
        tableView.dataSource = self
    }

    override func setupLocalization() {
        titleLabel.text = localize("leaderboard.title")
        filterSegmentControl.setTitle(localize("leaderboard.firstFilterSegmentControl"), forSegmentAt: 0)
        filterSegmentControl.setTitle(localize("leaderboard.secondFilterSegmentControl"), forSegmentAt: 1)
    }

    // MARK: - Private methods

    private func setupTableView() {
        tableView.register(UINib.init(nibName: LeaderboardTableViewCell.id, bundle: nil), forCellReuseIdentifier: LeaderboardTableViewCell.id)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

}

// MARK: - UITableViewDataSource

extension LeaderboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardPresenter.filteredPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.id, for: indexPath) as? LeaderboardTableViewCell
        else { return UITableViewCell() }

        var number = indexPath.row
        number += 1
        cell.update(with: leaderboardPresenter.filteredPlayers[safe: indexPath.row], number: number)

        return cell
    }
    
}



// MARK: - AddMatchViewProtocol

extension LeaderboardViewController: LeaderboardViewProtocol {

    func closeVC() {
        push(controller: .matches, fromStory: .matches)
    }

    func reloadTableView() {
        tableView.reloadData()
    }

}
