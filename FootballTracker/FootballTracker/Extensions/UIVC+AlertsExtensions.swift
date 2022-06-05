//
//  UIVC+AlertsExtensions.swift
//  FootballTracker
//
//  Created by Philip Boyko on 3.06.22.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
       
        present(alert, animated: true)
    }

}
