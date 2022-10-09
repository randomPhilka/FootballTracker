//
//  MatchTableViewCell.swift
//  FootballTracker
//
//  Created by Philip Boyko on 2.06.22.
//

import UIKit

final class MatchTableViewCell: UITableViewCell {

    static let id: String = String(describing: MatchTableViewCell.self)

    // MARK: - Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var teamOne: UILabel!
    @IBOutlet weak var teamTwo: UILabel!

    // MARK: - Overrides

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10))
    }

    // MARK: - Public methods

    func update(with match: MatchData?) {
        guard let match = match else { return }
        nameLabel.text = match.name
        scoreLabel.text = "\(match.scoreOne)-\(match.scoreTwo)"
        teamOne.text = match.teamOne
        teamTwo.text = match.teamTwo
    }

}
