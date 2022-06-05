//
//  AddMatchPresenterTests.swift
//  FootballTrackerTests
//
//  Created by Philip Boyko on 5.06.22.
//

import XCTest
@testable import FootballTracker

class AddMatchPresenterTests: XCTestCase {
    
    var matchesPersistence: MatchesPersistenceProviding {
        return lazyServicelocator.getService()
    }
    var match: Match!
    
    override func setUpWithError() throws {
        match = Match(id: UUID().uuidString, name: "testName", scoreOne: 4, scoreTwo: 5, teamOne: "Amos", teamTwo: "Diego")
    }
    
    override func tearDownWithError() throws {
        match = nil
    }
    
    func testSuccessAddMatch() {
        matchesPersistence.addMatch(match) { error in
            XCTAssertNil(error)
        }
        XCTAssertTrue(matchesPersistence.getMatches().contains { $0.id == match.id})
    }
    
    func testSuccessDeleteMatch() {
        matchesPersistence.deleteMatch(buID: match.id) { error in
            XCTAssertNil(error)
        }
        XCTAssertFalse(matchesPersistence.getMatches().contains { $0.id == match.id})
    }
    
}
