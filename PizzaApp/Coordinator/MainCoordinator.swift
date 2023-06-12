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
        let ingredientsScreen = IngredientsController()
        ingredientsScreen.coordinator = self
        ingredientsScreen.screenModel = IngredientsScreenModel(pizza: pizza, ingredients: ingredients)
        navigationController.pushViewController(ingredientsScreen, animated: false)
    }
    func closeViewConntroller() {
        navigationController.popViewController(animated: false)
    }
    func openBasket() {
        let cartScreen = CartScreenController()
        cartScreen.coordinator = self
        cartScreen.screenModel = CartModel.shared
        navigationController.pushViewController(cartScreen, animated: false)
    }
    func addToCart(pizza: MyPizza) {
        CartModel.shared.addPizza(pizza: pizza)
        navigationController.popViewController(animated: false)

        let addSuccessViewController = AddSuccessScreenScreenController()
        addSuccessViewController.coordinator = self
        navigationController.pushViewController(addSuccessViewController, animated: false)
    }
    func openDrinks() {
    }
}
