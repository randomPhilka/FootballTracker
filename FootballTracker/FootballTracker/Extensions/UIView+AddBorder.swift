//
//  UIView+AddBorder.swift
//  FootballTracker
//
//  Created by Philip Boyko on 08.10.22.
//

import UIKit

extension UIView {

    func setupBorder(color: UIColor? = .clear,
                     width: CGFloat = 0,
                     cornerRadius: CGFloat,
                     clipsToBounds: Bool = true,
                     corners: CACornerMask = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    ) {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
        layer.maskedCorners = corners
    }

}
