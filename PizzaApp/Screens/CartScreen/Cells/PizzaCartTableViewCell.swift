//
//  PizzaCartTableViewCell.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
import UIKit
final class PizzaCartTableViewCell: UITableViewCell {
    var pizza: MyPizza? {
        didSet {
            update()
        }
    }
    var tapAction: (() -> Void)?
    static var Identifier: String {
        return String(describing: self)
    }
    private lazy var title: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var price: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Constants.Pading.smallPadding
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        return stack
    }()
    private lazy var checkImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.Color.red
        return imageView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    @objc private func tap() {
        tapAction?()
    }
}
extension PizzaCartTableViewCell: CommonView {
    internal func initialize() {
        self.selectionStyle = .none
        self.backgroundColor = .clear

        setupSubviews()
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayout()
    }
    internal func setupSubviews() {
        stackView.addArrangedSubview(checkImage)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(price)
        contentView.addSubview(stackView)
        setupUserActions()
    }
    internal func setupLayout() {
        stackView.pinSidesToContainer(padding: Constants.Pading.regularPadding)
        contentView.layoutIfNeeded()
    }
    internal func update() {
        guard let item = pizza else { return }
        title.text = item.name
        price.text = "$" + String(describing: item.customPrice)
        checkImage.image =  UIImage(named: "ic_delete")?.withRenderingMode(.alwaysTemplate)
        setupLayout()
    }
    internal func setupUserActions() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
}
