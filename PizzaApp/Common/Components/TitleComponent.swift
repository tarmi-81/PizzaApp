//
//  TitleComponent.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 10/06/2023.
//

import Foundation
import UIKit

class TitleComponent: UIView {
    var pizzaItem: MyPizza? {
        didSet {
            update()
        }
    }
    var tapAction: (() -> Void)?
    private lazy var hstackBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.white2
        view.layer.opacity = Constants.UserInterface.titleBgOpacity
        return view
    }()
    private lazy var hstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.backgroundColor = .clear
        return stack
    }()
    private lazy var vstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillProportionally
        stack.backgroundColor = .clear
        return stack
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.bigBold
        return label
    }()
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.regular
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private lazy var basket: BasketCompoment = {
        let basket = BasketCompoment()
        return basket
    }()
    init(_ viewModel: MyPizza) {
        self.pizzaItem = viewModel
        super.init(frame: .zero)
        update()
    }
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
extension TitleComponent: CommonView {
    func setupUserActions() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    internal func initialize() {
        setupSubviews()
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayout()
    }
    func setupLayout() {
        vstackView.addArrangedSubview(title)
        vstackView.addArrangedSubview(subTitle)

        hstackView.addArrangedSubview(vstackView)
        hstackView.addArrangedSubview(basket)

        self.addSubview(hstackBackground)
        self.addSubview(hstackView)
        setupUserActions()
    }
    func setupSubviews() {
        hstackView.pinHorizontalSidesToContainer(padding: Constants.Pading.smallPadding)
        hstackView.bottomAnchor(equalTo: self.bottomAnchor)
        hstackView.heightAnchor(equalTo: Constants.UserInterface.titleComponentHeight)
        hstackBackground.pinHorizontalSidesToContainer()
        hstackBackground.bottomAnchor(equalTo: self.bottomAnchor)
        hstackBackground.heightAnchor(equalTo: Constants.UserInterface.titleComponentHeight)
        subTitle.widthAnchor(equalTo: 300)
        vstackView.widthAnchor(equalTo: 300)
    }
    func update() {
        guard let pizzaItem = pizzaItem else { return }
        title.text = pizzaItem.name
        subTitle.text = pizzaItem.ingredientsText.map({"\($0)"}).joined(separator: ", ")
        basket.price = pizzaItem.defaultPrice
        setupSubviews()
    }
}
