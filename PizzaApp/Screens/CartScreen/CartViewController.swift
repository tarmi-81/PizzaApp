//
//  CartViewController.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
import UIKit

final class CartViewController: UIViewController, UITableViewDelegate {
    var coordinator: Coordinator?
    var viewModel: CartViewModel?
    private lazy var checkOutButton: ActionButton = {
        let view = ActionButton()
        return view
    }()
    private lazy var tableView: UITableView =  {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.separatorColor = Constants.Color.lightGray
        table.rowHeight = 50
        table.isUserInteractionEnabled = true
        return table
    }()
    private lazy var rightNavButton: UIBarButtonItem = {
        let button =  UIBarButtonItem(image: UIImage(named: "ic_drinks"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(openDrinks))
        button.tintColor = Constants.Color.red
        return button
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.white
        view.addSubview(tableView)
        view.addSubview(checkOutButton)
        setUpNavigationBar()
        setUpContstrains()
        setUpContent()
    }
    public override func viewDidAppear(_ animated: Bool) {
        updateButton()
        tableView.reloadData()
    }
    @objc fileprivate func openDrinks() {
        if let mainCoordinator = coordinator as? MainCoordinator {
            mainCoordinator.openDrinks()
        }
    }
    func updateButton() {
        guard let screenModel = viewModel else {
            checkOutButton.layer.opacity = 0.8
            checkOutButton.isUserInteractionEnabled = false
            return
        }
        if screenModel.pizzas.isEmpty && screenModel.drinks.isEmpty {
            checkOutButton.layer.opacity = 0.8
            checkOutButton.isUserInteractionEnabled = false
        } else {
            checkOutButton.layer.opacity = 1
            checkOutButton.isUserInteractionEnabled = true
        }
    }
}
extension CartViewController: CommonViewController {
    internal func setUpContent() {
        updateButton()
        checkOutButton.text = "CHECKOUT"
        checkOutButton.tapAction = { [self] in
            if let mainCoordinator = coordinator as? MainCoordinator {
                mainCoordinator.checkOut()
            }
        }
    }
    internal func setUpContstrains() {
        tableView.topAnchor(equalTo: view.safeAreaLayoutGuide.topAnchor,
                            padding: Constants.Pading.regularPadding)
        tableView.bottomAnchor(equalTo: checkOutButton.topAnchor)
        tableView.pinHorizontalSidesToContainer()
        checkOutButton.pinHorizontalSidesToContainer()
        checkOutButton.bottomAnchor(equalTo: view.bottomAnchor)
        checkOutButton.heightAnchor(equalTo: 85.0)
    }
    internal func setUpNavigationBar() {
        title = "CART"
        navigationItem.rightBarButtonItem = rightNavButton
        self.navigationController?.navigationBar.backItem?.title = " "
        coordinator?.navigationController.navigationBar.tintColor  = Constants.Color.red
        coordinator?.navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constants.Color.red,
            NSAttributedString.Key.font: Constants.Font.bigBold
        ]
    }
}
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pizzas = viewModel?.pizzas,
              let drinks = viewModel?.drinks else { return 1 }
        return pizzas.count + drinks.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pizzas = viewModel?.pizzas,
              let drinks = viewModel?.drinks else { return UITableViewCell()}
        let totalPriceIndexPath = IndexPath(row: (pizzas.count + drinks.count), section: 0)
        let indexOfElement = indexPath.row
        if   indexOfElement < pizzas.count {
            let cell: PizzaCartTableViewCell = tableView.dequeueCell(for: indexPath)
            let myPizza = pizzas[indexPath.row]
            cell.pizza = myPizza
            cell.tapAction = { [self] in
                viewModel?.removePizza(pizza: myPizza)
                tableView.reloadData()
                updateButton()
            }
            return cell
        } else if indexOfElement  >= pizzas.count && indexOfElement < totalPriceIndexPath.row {
            let cell: DrinkCartTableViewCell = tableView.dequeueCell(for: indexPath)
            let index = indexPath.row - pizzas.count
            let drink = drinks[index]
            cell.drink = drink
            cell.tapAction = { [self] in
                viewModel?.removeDrink(drink: drink)
                tableView.reloadData()
                updateButton()
            }
            return cell
        } else if indexOfElement ==  totalPriceIndexPath.row {
            let cell: TotalTableViewCell = tableView.dequeueCell(for: indexPath)
            cell.priceValue = viewModel?.totalPrice
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
