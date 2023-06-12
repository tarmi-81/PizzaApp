//
//  ActionButton.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
import UIKit
class ActionButton: UIView {
    var text: String? {
        didSet {
            update()
        }
    }
    var bgColor: UIColor = Constants.Color.red
    var tapAction: (() -> Void)?
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.Pading.smallPadding
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        return stack
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Font.regularBold
        label.textAlignment = .center
        return label
    }()

    required init() {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func tap() {
        tapAction?()
    }
}

extension ActionButton: CommonView {
   internal func initialize() {
        setupSubviews()
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayout()
    }
    internal func setupSubviews() {
        stackView.pinSidesToContainer()
    }
    internal func setupLayout() {
        self.backgroundColor = bgColor
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(UIView())
        self.addSubview(stackView)
        setupUserActions()
    }
    internal func setupUserActions() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    internal func update() {
        title.text = text
        setupSubviews()
    }
}
