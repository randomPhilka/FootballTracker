//
//  CollectionExtensions.swift
//  FootballTracker
//
//  Created by Philip Boyko on 2.06.22.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}
