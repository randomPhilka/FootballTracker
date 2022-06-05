//
//  AddMatchViewController.swift
//  FootballTracker
//
//  Created by Philip Boyko on 3.06.22.
//

import UIKit

protocol AddMatchViewProtocol: AnyObject {
    func closeVC()
    func setScore(_ score: Int, forTeam: Team)
    func presentAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
}

final class AddMatchViewController: DefaultViewController {

    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var matchNameLabel: UILabel!
    @IBOutlet weak var firstPersonLabel: UILabel!
    @IBOutlet weak var secondPersonLabel: UILabel!
    @IBOutlet var nameLabel: [UILabel]!
    @IBOutlet var scoreLabel: [UILabel]!
    @IBOutlet weak var matchNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var firstScoreValueLabel: UILabel!
    @IBOutlet weak var secondScoreValueLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: - Actions

    @IBAction func firstStepperTaped(_ sender: UIStepper) {
        addMatchPresenter.updateScore(Int(sender.value), forTeam: .one)
    }

    @IBAction func secondStepperTaped(_ sender: UIStepper) {
        addMatchPresenter.updateScore(Int(sender.value), forTeam: .two)
    }

    @IBAction func backButtonTaped(_ sender: Any) {
        addMatchPresenter.backButtonTaped()
    }

    @IBAction func saveButtonTaped(_ sender: Any) {
        addMatchPresenter.saveMatch(name: matchNameTextField.text,
                                    teamOne: firstNameTextField.text,
                                    teamTwo: secondNameTextField.text)
    }

    // MARK: - Properties

    lazy var addMatchPresenter = AddMatchPresenter(self)

    // MARK: - Overrides

    override func setupLocalization() {
        titleLabel.text = localize("addMatch.titleLabel")
        matchNameLabel.text = localize("addMatch.matchNameLabel")
        firstPersonLabel.text = localize("addMatch.firstPersonLabel")
        secondPersonLabel.text = localize("addMatch.secondPersonLabel")
        nameLabel.forEach { $0.text = localize("addMatch.nameLabel") }
        scoreLabel.forEach { $0.text = localize("addMatch.scoreLabel") }
        saveButton.setTitle(localize("addMatch.saveButton"), for: .normal)
    }

}

// MARK: - AddMatchViewProtocol

extension AddMatchViewController: AddMatchViewProtocol {

    func setScore(_ score: Int, forTeam: Team) {
        switch forTeam {
        case .one:
            firstScoreValueLabel.text = String(score)
        case .two:
            secondScoreValueLabel.text = String(score)
        }
    }

    func closeVC() {
        navigationController?.popViewController(animated: true)
    }

    func presentAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        showAlert(title: title, message: message, handler: handler)
    }

}
