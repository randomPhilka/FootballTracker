//
//  Player.swift
//  FootballTracker
//
//  Created by Philip Boyko on 08.10.22.
//

import Foundation

struct Player {
    let name: String
    let winCurrentGame: Bool

    init(name: String, winCurrentGame: Bool) {
        self.name = name
        self.winCurrentGame = winCurrentGame
    }
}
