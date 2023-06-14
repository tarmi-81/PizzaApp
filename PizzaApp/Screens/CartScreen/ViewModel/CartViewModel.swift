//
//  CartModel.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
final class CartViewModel {
    static let shared = CartViewModel()
    var pizzas: [MyPizza] = [] {
        didSet {
            updatePrice()
        }
    }
    var drinks: [DrinkItem] = [] {
        didSet {
            updatePrice()
        }
    }
    var totalPrice: Double = 0
    public func addPizza(pizza: MyPizza) {
        var newPizza = pizza
        newPizza.id? = UUID()
        pizzas.append(newPizza)
    }
    public func addDrink(drink: DrinkItem) {
        drinks.append(drink)
    }
    public func removePizza(pizza: MyPizza) {
        if let itemIndex = pizzas.firstIndex(where: { $0.id == pizza.id }) {
            pizzas.remove(at: itemIndex)
        }
    }
    public func removeDrink(drink: DrinkItem) {
        if let itemIndex = drinks.firstIndex(where: { $0.id == drink.id }) {
            drinks.remove(at: itemIndex)
        }
    }
    private func updatePrice() {
        totalPrice = 0
        let pizzaPricesArray: [Double] =  pizzas.map { myPizza in
           return  myPizza.customPrice
        }
        let drinkPricesArray: [Double] =  drinks.map { myDrink in
            return  myDrink.price
        }
        totalPrice += pizzaPricesArray.reduce(0, +)
        totalPrice += drinkPricesArray.reduce(0, +)
    }
}
