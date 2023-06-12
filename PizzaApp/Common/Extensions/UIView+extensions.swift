//
//  UIView+Extensions.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 10/06/2023.
//

import Foundation
import UIKit
public extension UIView {
    func pinSidesToContainer(padding: CGFloat = 0) {
        guard let container = superview else {
            debugPrint("View \(self) has no superview")
            return
        }
        pinSides(toSidesofView: container, padding: padding)
    }
    func pinHorizontalSidesToContainer(padding: CGFloat = 0) {
        guard let container = superview else {
            debugPrint("View \(self) has no superview")
            return
        }
        self.pinHorizontalSides(toSidesOfView: container, padding: padding)
    }
    func pinVerticalSidesToContainer(padding: CGFloat = 0) {
        guard let container = superview else {
            debugPrint("View \(self) has no superview")
            return
        }
        self.pinVerticalSides(toSidesOfView: container, padding: padding)
    }
    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutYAxisAnchor,
                   padding constant: CGFloat = 0,
                   priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.topAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutYAxisAnchor,
                      padding  constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.bottomAnchor.constraint(equalTo: anchor, constant: -constant)
        constraint.isActive = true
        return constraint
    }
    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutXAxisAnchor,
                       padding constant: CGFloat = 0,
                       priority: UILayoutPriority = .required ) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.leadingAnchor.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutXAxisAnchor,
                        priority: UILayoutPriority = .required,
                        padding constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.trailingAnchor.constraint(equalTo: anchor, constant: -constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    @discardableResult
    func heightAnchor(equalTo constant: CGFloat,
                      priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.heightAnchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    @discardableResult
    func widthAnchor(equalTo constant: CGFloat,
                     priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = self.widthAnchor.constraint(equalToConstant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    private func pinSides(toSidesofView view: UIView, padding: CGFloat = 0) {
        self.pinVerticalSides(toSidesOfView: view, padding: padding)
        self.pinHorizontalSides(toSidesOfView: view, padding: padding)
    }
    private func pinHorizontalSides(toSidesOfView view: UIView, padding: CGFloat = 0) {
        self.leadingAnchor(equalTo: view.leadingAnchor, padding: padding)
        self.trailingAnchor(equalTo: view.trailingAnchor, padding: padding)
    }
    private func pinVerticalSides(toSidesOfView view: UIView, padding: CGFloat = 0) {
        self.topAnchor(equalTo: view.topAnchor, padding: padding)
        self.bottomAnchor(equalTo: view.bottomAnchor, padding: padding)
    }
}
