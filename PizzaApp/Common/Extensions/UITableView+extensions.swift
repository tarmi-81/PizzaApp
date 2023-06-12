//
//  UITableView+extensions.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 11/06/2023.
//

import Foundation
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UITableView {
    func register<T: UITableViewCell>(_ cell: T.Type) {
        register(cell.self, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        register(T.self)
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cannot dequeue cell of type \(T.self)")
        }
        return cell
    }
}
