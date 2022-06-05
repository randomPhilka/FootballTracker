//
//  ValidationError.swift
//  FootballTracker
//
//  Created by Philip Boyko on 5.06.22.
//

import Foundation

enum ValidationError: Error {
    case invalidMatchName
    case invalidTeamOneName
    case invalidTeamTwoName
    case emptyFields
    case multiple([ValidationError])
}

extension ValidationError: LocalizedError {

    var failureReason: String? {
        switch self {
        case .invalidMatchName:
            return localize("validationError.invalidMatchName")
        case .invalidTeamOneName:
            return localize("validationError.invalidTeamOneName")
        case .invalidTeamTwoName:
            return localize("validationError.invalidTeamTwoName")
        case .emptyFields:
            return localize("validationError.emptyFields")
        case .multiple(let errors):
            let reasons = errors.compactMap { $0.failureReason }.joined(separator: ". ")
            return reasons
        }
    }

}
