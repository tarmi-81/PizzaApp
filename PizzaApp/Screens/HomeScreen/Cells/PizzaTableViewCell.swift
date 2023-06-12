//
//  PizzaTableViewCell.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 10/06/2023.
//

import Foundation
import UIKit

final class PizzaTableViewCell: UITableViewCell {
    var pizzaItem: MyPizza? {
        didSet {
            update()
        }
    }
    var tapAction: (() -> Void)?
    private var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var title: TitleComponent = {
        let title = TitleComponent()
        title.tapAction = { [self] in
            tap()
        }
        return title
    }()
    static var Identifier: String {
        return String(describing: self)
    }
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
extension PizzaTableViewCell: CommonView {
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
        contentView.addSubview(image)
        contentView.addSubview(title)
        setupUserActions()
    }
    internal func setupLayout() {
        image.pinSidesToContainer()
        title.pinHorizontalSidesToContainer()
        title.bottomAnchor(equalTo: contentView.bottomAnchor)
        title.heightAnchor(equalTo: 85.0)
        contentView.layoutIfNeeded()
    }
    internal func update() {
        guard let item = pizzaItem else { return }
        image.downloadedCrop(from: item.imageUrl ?? "")
        contentView.layer.contents = UIImage(named: "bg_wood")?.cgImage

        title.pizzaItem = item
        setupLayout()
    }
    func setupUserActions() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
}
