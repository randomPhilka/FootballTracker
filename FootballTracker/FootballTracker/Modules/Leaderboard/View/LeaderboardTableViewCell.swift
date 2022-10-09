//
//  LeaderboardTableViewCell.swift
//  FootballTracker
//
//  Created by Philip Boyko on 07.10.22.
//

import UIKit

final class LeaderboardTableViewCell: UITableViewCell {

    static let id: String = String(describing: LeaderboardTableViewCell.self)

    // MARK: - Outlets

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var gamesLabel: UILabel!

    // MARK: - Properties

    private let topNumbersRange = 1...3

    // MARK: - Public methods

    func update(with player: PlayerData?, number: Int) {
        numberLabel.backgroundColor = topNumbersRange.contains(number) ? UIColor(named: "AppPink") : .white
        numberLabel.textColor = topNumbersRange.contains(number) ? .white :  UIColor(named: "AppPink")
        numberLabel.text = String(number)
        nameLabel.text = player?.name
        winsLabel.text = localize("leaderboard.wins", String(player?.wins ?? 0))
        gamesLabel.text = localize("leaderboard.games", String(player?.games ?? 0))
    }

}
