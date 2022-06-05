//
//  LocalizationExtensions.swift
//  FootballTracker
//
//  Created by Philip Boyko on 1.06.22.
//

import Foundation

func localize(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func localize(_ key: String, _ value: String) -> String {
    return String(format: localize(key), value)
}
