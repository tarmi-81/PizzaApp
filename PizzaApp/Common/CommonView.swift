//
//  CommonViewProtocol.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 10/06/2023.
//

import Foundation
import UIKit

protocol CommonView {
    init()
    init?(coder: NSCoder)
    func initialize()
    func setupSubviews()
    func setupLayout()
    func update()
    func didMoveToSuperview()
    func setupUserActions()
}
