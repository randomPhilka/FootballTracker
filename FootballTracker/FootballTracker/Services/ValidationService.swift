//
//  ValidationService.swift
//  FootballTracker
//
//  Created by Philip Boyko on 5.06.22.
//

import Foundation

protocol ValidationServiceProviding {
    func validateMatch(name: String?, teamOne: String?, teamTwo: String?) throws -> Bool
}

final class ValidationServiceProvider: ValidationServiceProviding {
    
    //MARK: - Public
    
    func validateMatch(name: String?, teamOne: String?, teamTwo: String?) throws -> Bool {
        guard name != "" &&
                teamOne != "" &&
                teamTwo != ""
        else {
            throw ValidationError.emptyFields
        }
        
        var errors: [ValidationError] = []

        if isUsernameValid(name) {
            errors.append(.invalidMatchName)
        } else if isUsernameValid(teamOne) {
            errors.append(.invalidTeamOneName)
        } else if isUsernameValid(teamTwo) {
            errors.append(.invalidTeamTwoName)
        }

        if errors.isEmpty {
            return true
        } else {
            throw ValidationError.multiple(errors)
        }
    }

    
    //MARK: - Private

    private func isUsernameValid(_ username: String?) -> Bool {
        guard let username = username else { return false }
        let usernameReg = ("^[A-Z]([A-Z0-9_]*[A-Z])?$")
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameReg)
        return usernameTest.evaluate(with: username)
    }

}
