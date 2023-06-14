//
//  HomeScreenViewController.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 09/06/2023.
//

import Foundation
import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate {
    var coordinator: Coordinator?
    private var viewModel: HomesScreenViewModel = HomesScreenViewModel()
    private lazy var tableView: UITableView =  {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.rowHeight = 178
        table.isUserInteractionEnabled = true
        return table
    }()
    private lazy var leftNavButton: UIBarButtonItem = {
        let button =  UIBarButtonItem(image: UIImage(named: "ic_cart_navbar"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(openBasket))
        button.tintColor =  Constants.Color.red
        return button
    }()
    private lazy var rightNavButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(createCustomPizza))
        button.tintColor = Constants.Color.red
        return button
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        view.backgroundColor = Constants.Color.white
        view.addSubview(tableView)
        setUpNavigationBar()
        setUpContstrains()
    }
    @objc fileprivate func openBasket() {
        if let mainCoordinator = coordinator as? MainCoordinator {
            mainCoordinator.openBasket()
        }
    }
    @objc fileprivate func createCustomPizza() {
        guard let ingrediensData = viewModel.ingrediensData else { return }
        let myPizza = MyPizza(name: "CREATE A PIZZA",
                              ingredients: [],
                              imageUrl: nil,
                              defaultPrice: viewModel.defaultPrice,
                              ingredientsText: [],
                              customIngredients: [],
                              customPrice: viewModel.defaultPrice)

            createPizza(pizza: myPizza,
                        ingredients: ingrediensData)

    }
    private func createPizza(pizza: MyPizza,
                             ingredients: [IngredientItem]) {
        if let mainCoordinator = coordinator as? MainCoordinator {
            mainCoordinator.addPizza(pizza: pizza, ingredients: ingredients)
        }
    }
}
extension HomeScreenViewController: CommonViewController {
    internal func setUpContent() {}
    internal func setUpContstrains() {
        tableView.pinSidesToContainer()
    }
    internal func setUpNavigationBar() {
        navigationItem.leftBarButtonItem = leftNavButton
        navigationItem.rightBarButtonItem = rightNavButton
        title = "Nenno's pizza"
        coordinator?.navigationController.navigationBar.tintColor  = Constants.Color.red
        coordinator?.navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constants.Color.red,
            NSAttributedString.Key.font: Constants.Font.regularBold
        ]
    }
}
extension HomeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pizzasData = viewModel.pizzasData else { return 0}
        return pizzasData.pizzas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pizzasData = viewModel.pizzasData,
              let ingredients = viewModel.ingrediensData else { return UITableViewCell() }

        let cell: PizzaTableViewCell = tableView.dequeueCell(for: indexPath)
        let pizzaItem = pizzasData.pizzas[indexPath.row]
        cell.pizzaItem = pizzaItem
        cell.tapAction = { [self] in
            createPizza(pizza: pizzaItem, ingredients: ingredients)
        }
        return cell
    }

}
