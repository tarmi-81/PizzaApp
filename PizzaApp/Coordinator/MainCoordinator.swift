//
//  MainCoordinator.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 11/06/2023.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let homeScreen = HomeScreenViewController()
        homeScreen.coordinator = self
        navigationController.pushViewController(homeScreen, animated: false)
    }
    func addPizza(pizza: MyPizza, ingredients: [IngredientItem]) {
        let ingredientsScreen = IngredientsViewController()
        ingredientsScreen.coordinator = self
        ingredientsScreen.viewModel = IngredientsViewModel(pizza: pizza, ingredients: ingredients)
        navigationController.pushViewController(ingredientsScreen, animated: false)
    }
    func closeViewConntroller() {
        navigationController.popViewController(animated: false)
    }
    func openBasket() {
        let cartScreen = CartViewController()
        cartScreen.coordinator = self
        cartScreen.viewModel = CartViewModel.shared
        navigationController.pushViewController(cartScreen, animated: false)
    }
    func addToCart(pizza: MyPizza) {
        CartViewModel.shared.addPizza(pizza: pizza)
        navigationController.popViewController(animated: false)

        let addSuccessViewController = AddSuccessViewController()
        addSuccessViewController.coordinator = self
        navigationController.pushViewController(addSuccessViewController, animated: false)
    }
    func addToCart(drink: DrinkItem) {
        CartViewModel.shared.addDrink(drink: drink)
        if let cartViewControler = navigationController.popViewController(animated: false) as? CartViewController {
            cartViewControler.viewDidAppear(false)
        }
    }
    func openDrinks() {
        let drinksScreen = DrinksViewController()
        drinksScreen.coordinator = self
        navigationController.pushViewController(drinksScreen, animated: true)
    }
    func checkOut() {
        navigationController.popViewController(animated: false)
        let checkOutScreen = CheckOutViewController()
        checkOutScreen.coordinator = self
        navigationController.pushViewController(checkOutScreen, animated: false)
    }

}
