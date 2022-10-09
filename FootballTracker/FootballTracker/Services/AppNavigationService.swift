//
//  AppNavigationService.swift
//  FootballTracker
//
//  Created by Philip Boyko on 1.06.22.
//

import UIKit

enum StoryController: String{
    case matches
    case addMatch
    case leaderboard

    // MARK: - Public
    
    var identifier: String {
        let words = rawValue.components(separatedBy: "_")
        return words.reduce("") { return $0 + ($1.prefix(1).capitalized + $1.dropFirst()) + "ViewController" }
    }

}

enum StoryType: String {
    case matches
    case addMatch
    case leaderboard

    // MARK: - Public

    var storyboard: UIStoryboard {
        return getStoryboard()
    }
    
    // MARK: - Private

    private func getStoryboard() -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }

    private var name: String {
        let words = rawValue.components(separatedBy: "_")
        return words.reduce("") { return $0 + ($1.prefix(1).capitalized + $1.dropFirst()) }
    }
}
