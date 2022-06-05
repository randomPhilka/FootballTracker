//
//  DefaultViewController.swift
//  FootballTracker
//
//  Created by Philip Boyko on 2.06.22.
//

import UIKit

class DefaultViewController: UIViewController {

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        setupUI()
        setupDelegates()
    }

    // MARK: - Public functions

    func setupUI() {}
    func setupLocalization() {}
    func setupDelegates() {}

}
