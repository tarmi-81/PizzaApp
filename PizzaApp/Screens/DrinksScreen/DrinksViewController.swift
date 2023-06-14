//
//  DrinksViewController.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 14/06/2023.
//

import Foundation
import UIKit

final class DrinksViewController: UIViewController, UITableViewDelegate {
    var coordinator: Coordinator?
    var viewModel: DrinksViewModel = DrinksViewModel()

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
        setUpContent()
    }
    @objc fileprivate func openDrinks() {
        if let mainCoordinator = coordinator as? MainCoordinator {
            mainCoordinator.openDrinks()
        }
    }
}
extension DrinksViewController: CommonViewController {
    internal func setUpContent() { }
    internal func setUpContstrains() {
        tableView.topAnchor(equalTo: view.safeAreaLayoutGuide.topAnchor,
                            padding: Constants.Pading.regularPadding)
        tableView.bottomAnchor(equalTo: view.bottomAnchor)
        tableView.pinHorizontalSidesToContainer()

    }
    internal func setUpNavigationBar() {
        title = "DRINKS"
        self.navigationController?.navigationBar.backItem?.title = " "
        coordinator?.navigationController.navigationBar.tintColor  = Constants.Color.red
        coordinator?.navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constants.Color.red,
            NSAttributedString.Key.font: Constants.Font.bigBold
        ]
    }
}
extension DrinksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let drinks = viewModel.drinksData else { return 0 }
        return drinks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let drinks = viewModel.drinksData else { return UITableViewCell() }
        let cell: DrinkTableViewCell = tableView.dequeueCell(for: indexPath)
        let drink = drinks[indexPath.row]
        cell.drink = drink
        cell.tapAction = { [self] in
            if let mainCoordinator = coordinator as? MainCoordinator {
                mainCoordinator.addToCart(drink: drink)
            }
        }
        return cell
    }
}
