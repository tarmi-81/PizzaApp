//
//  CartScreenController.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
import UIKit

class CartScreenController: UIViewController, UITableViewDelegate {
    var coordinator: Coordinator?
    var screenModel: CartModel?
    private lazy var checkOutbutton: ActionButton = {
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
        view.addSubview(checkOutbutton)
        setUpNavigationBar()
        setUpContstrains()
        setUpContent()
    }
    @objc fileprivate func openDrinks() {
        if let mainCoordinator = coordinator as? MainCoordinator {
            mainCoordinator.openDrinks()
        }
    }
}
extension CartScreenController: CommonViewController {
    internal func setUpContent() {
        checkOutbutton.text = "CHECKOUT"
        checkOutbutton.tapAction = {
            // TODO: checkOut
        }
    }
    internal func setUpContstrains() {
        tableView.topAnchor(equalTo: view.safeAreaLayoutGuide.topAnchor,
                            padding: Constants.Pading.regularPadding)
        tableView.bottomAnchor(equalTo: checkOutbutton.topAnchor)
        tableView.pinHorizontalSidesToContainer()
        checkOutbutton.pinHorizontalSidesToContainer()
        checkOutbutton.bottomAnchor(equalTo: view.bottomAnchor)
        checkOutbutton.heightAnchor(equalTo: 85.0)
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
extension CartScreenController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pizzas = screenModel?.pizzas else { return 0 }
        return pizzas.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pizzas = screenModel?.pizzas,
              let drinks = screenModel?.drinks else { return UITableViewCell()}
        let totalPriceIndexPath = IndexPath(row: (pizzas.count + drinks.count), section: 0)
        switch indexPath.row {
        case ..<pizzas.count:
            let cell: PizzaCartTableViewCell = tableView.dequeueCell(for: indexPath)
            let myPizza = pizzas[indexPath.row]
            cell.pizza = myPizza
            cell.tapAction = { [self] in
                screenModel?.removePizza(pizza: myPizza)
                tableView.reloadData()
            }
            return cell
        case totalPriceIndexPath.row:
            let cell: TotalTableViewCell = tableView.dequeueCell(for: indexPath)
            cell.priceValue = screenModel?.totalPrice
            return cell
        default:
            return UITableViewCell()
        }
    }
}
