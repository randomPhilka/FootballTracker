//
//  UIVC+NavigationExtensions.swift
//  FootballTracker
//
//  Created by Philip Boyko on 1.06.22.
//

import UIKit

extension UIViewController {

    func present(controller: StoryController, fromStory: StoryType, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        let controller = fromStory.storyboard.instantiateViewController(withIdentifier: controller.identifier)
        controller.modalPresentationStyle = modalPresentationStyle
        present(controller, animated: animated, completion: nil)
    }

    func push(controller: StoryController, fromStory: StoryType, animated: Bool = true) {
        let controller = fromStory.storyboard.instantiateViewController(withIdentifier: controller.identifier)
        navigationController?.pushViewController(controller, animated: animated)
    }

}

