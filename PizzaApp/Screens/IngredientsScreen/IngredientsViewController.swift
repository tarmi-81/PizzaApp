//
//  IngredientsViewController.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 11/06/2023.
//

import Foundation
import UIKit

final class IngredientsViewController: UIViewController, UITableViewDelegate {
    var coordinator: Coordinator?
    var viewModel: IngredientsViewModel?

    private lazy var imageBg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bg_wood")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var pizzaImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private lazy var tableTitle: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.bigBold
        label.textColor = .black
        return label
    }()
    private lazy var addButton: ActionButton = {
        let view = ActionButton()
        view.bgColor = Constants.Color.yellow
        return view
    }()
    private lazy var tableView: UITableView =  {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(PizzaTableViewCell.self, forCellReuseIdentifier: PizzaTableViewCell.Identifier)
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.separatorColor = Constants.Color.lightGray
        table.rowHeight = 50
        table.isUserInteractionEnabled = true
        return table
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.white
        imageBg.addSubview(pizzaImage)
        view.addSubview(imageBg)
        view.addSubview(addButton)
        view.addSubview(tableTitle)
        view.addSubview(tableView)
        setUpNavigationBar()
        setUpContstrains()
        setUpContent()
    }
    private func currentPrice() -> String {
        guard let customPrice = viewModel?.pizzaData?.customPrice  else { return "-" }
        return "ADD TO CARD ($" + String(format: "%.2f", customPrice) + ")"
    }
}
extension IngredientsViewController: CommonViewController {
    internal func setUpContent() {
        if let imageUrl = viewModel?.pizzaData?.imageUrl {
            pizzaImage.downloaded(from: imageUrl)
        }
        tableTitle.text = "Ingredients"
        addButton.text = currentPrice()
        addButton.tapAction = { [self] in
            if let mainCoordinator = coordinator as? MainCoordinator,
               let pizza = viewModel?.pizzaData {
                mainCoordinator.addToCart(pizza: pizza)
            }
        }
    }
    internal func setUpContstrains() {
        imageBg.topAnchor(equalTo: view.safeAreaLayoutGuide.topAnchor,
                          padding: Constants.Pading.smallPadding)
        imageBg.pinHorizontalSidesToContainer()
        imageBg.heightAnchor(equalTo: 300)
        pizzaImage.pinSidesToContainer(padding: Constants.Pading.smallPadding)
        addButton.pinHorizontalSidesToContainer()
        addButton.bottomAnchor(equalTo: view.bottomAnchor)
        addButton.heightAnchor(equalTo: 85.0)
        tableTitle.pinHorizontalSidesToContainer(padding: Constants.Pading.smallPadding)
        tableTitle.topAnchor(equalTo: imageBg.bottomAnchor,
                             padding: Constants.Pading.regularPadding)
        tableView.topAnchor(equalTo: tableTitle.bottomAnchor,
                            padding: Constants.Pading.regularPadding)
        tableView.bottomAnchor(equalTo: addButton.topAnchor)
        tableView.pinHorizontalSidesToContainer()
    }
    internal func setUpNavigationBar() {
        title = viewModel?.pizzaData?.name
        self.navigationController?.navigationBar.backItem?.title = " "
        coordinator?.navigationController.navigationBar.tintColor  = Constants.Color.red
        coordinator?.navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constants.Color.red,
            NSAttributedString.Key.font: Constants.Font.bigBold
        ]
    }
}
extension IngredientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = viewModel?.ingrediensData else { return 0 }
        return ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ingredients = viewModel?.ingrediensData else { return UITableViewCell()}

        let cell: IgredientsTableViewCell = tableView.dequeueCell(for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.ingredient = ingredient
        cell.tapAction = { [self] in
            viewModel?.checkItem(item: ingredient) { [self] in
                tableView.beginUpdates()
                tableView.reloadRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                addButton.text = currentPrice()
            }
        }
        return cell
    }
}
