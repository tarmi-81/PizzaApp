//
//  BasketCompoment.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 10/06/2023.
//

import Foundation
import UIKit

class BasketCompoment: UIView {
    var price: Double? {
        didSet {
            update()
        }
    }
    var tapAction: (() -> Void)?
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = Constants.Color.yellow
        return stack
    }()
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_cart_navbar")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.Color.white
        return imageView
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Font.smallBold
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

extension BasketCompoment: CommonView {
    internal func setupUserActions() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    internal func initialize() {
        setupSubviews()
    }
    internal override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayout()
    }
    internal func setupLayout() {
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(title)
        self.addSubview(stackView)
        setupUserActions()
    }
    internal func setupSubviews() {
        stackView.heightAnchor(equalTo: Constants.UserInterface.basketCompomentHeight)
        stackView.bottomAnchor(equalTo: self.bottomAnchor, padding: Constants.Pading.smallPadding)
        stackView.trailingAnchor(equalTo: self.trailingAnchor)
        stackView.layer.cornerRadius = Constants.UserInterface.cornerRadius
    }
    internal func update() {
        guard let price = price else { return }
        title.text = "$ " + String(price) + " "
        setupSubviews()
    }
}
