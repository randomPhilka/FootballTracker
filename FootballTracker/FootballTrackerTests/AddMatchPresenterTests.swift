//
//  AddMatchPresenterTests.swift
//  FootballTrackerTests
//
//  Created by Philip Boyko on 6.06.22.
//

import XCTest
@testable import FootballTracker

class AddMatchPresenterTests: XCTestCase {

    var matchesPersistence: MatchesPersistenceProviding {
        return lazyServicelocator.getService()
    }
    var match = Match(id: UUID().uuidString,
                      name: "testName",
                      scoreOne: 4, scoreTwo: 5,
                      teamOne: "Amos",
                      teamTwo: "Diego")

    func testAddMatch() {
        matchesPersistence.addMatch(match) { [weak self] error in
            guard let self = self else { return }
            XCTAssertNil(error)
            XCTAssertTrue(self.matchesPersistence.getMatches().contains { $0.id == self.match.id})
        }
    }

    func testDeleteMatch() {
        matchesPersistence.deleteMatch(buID: match.id) { error in
            XCTAssertNil(error)
        }
        XCTAssertFalse(matchesPersistence.getMatches().contains { $0.id == match.id})
    }
    
}
