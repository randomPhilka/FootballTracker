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

    func pushFromRightToLeft(controller: StoryController, fromStory: StoryType, animated: Bool = true) {
        let controller = fromStory.storyboard.instantiateViewController(withIdentifier: controller.identifier)
        let transition = CATransition()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(controller, animated: false)
    }

}

