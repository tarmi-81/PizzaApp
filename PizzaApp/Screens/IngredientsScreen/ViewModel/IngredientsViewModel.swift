//
//  IngredientsViewModel.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 11/06/2023.
//

import Foundation

final class IngredientsViewModel {
    var pizzaData: MyPizza?
    var ingrediensData: [IngredientsSelectItem]?
    init(pizza: MyPizza, ingredients: [IngredientItem]) {
        self.pizzaData = pizza
        self.ingrediensData = ingredients.map({ item in
            let isSelected = pizzaData?.customIngredients.first(where: { $0 == item.id }) != nil ? true : false
            return  IngredientsSelectItem(id: item.id, name: item.name, price: item.price, isSelected: isSelected )
        })
    }
    public func checkItem(item: IngredientsSelectItem, completion: @escaping () -> Void ) {
        guard var pizza = pizzaData else { return }
        if let itemIndex = pizza.customIngredients.firstIndex(where: { $0 == item.id }) {
            pizzaData?.customIngredients.remove(at: itemIndex)
        } else {
            pizzaData?.customIngredients.append(item.id)
        }
        if let itemIndex = ingrediensData?.firstIndex(where: { $0.id == item.id }) {
            if let item = ingrediensData?[itemIndex] {
                let  newSelected = !item.isSelected
                ingrediensData?[itemIndex].isSelected = newSelected

                if pizza.ingredients.first(where: { $0 == item.id }) == nil {
                    pizza.customPrice += item.price * (newSelected ? 1 : -1)
                }
                if pizza.customPrice > pizza.defaultPrice {
                    pizzaData?.customPrice = pizza.customPrice
                } else {
                    pizzaData?.customPrice = pizza.defaultPrice
                }
            }
        }
        completion()
    }
    private func mapIndrediemsToString(_ ingrediensInt: [Int64]) -> [String] {
        return  ingrediensInt.map { ingredientCode in
            return ingrediensData?.first(where: {$0.id == ingredientCode})?.name ?? ""
        }
    }
}
