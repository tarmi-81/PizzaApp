//
//  HomesScreenViewModel.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 11/06/2023.
//

import Foundation

final class HomesScreenViewModel {
    private var apiPizzasData: Pizzas?
    var pizzasData: HomeScreenPizzas?
    var ingrediensData: [IngredientItem]?
    var defaultPrice: Double = 0
    func loadData(completion: @escaping () -> Void ) {
        loadPizzas { [self] in
            loadIngrediens { [self] in
                mapHomeScreenPizzas()
                completion()
            }
        }
    }
    private func loadPizzas(completion: @escaping () -> Void ) {
        ServerAPI().loadData(urlString: ServerAPI.Api.pizzas) {  [self] (data: Pizzas?) in
            apiPizzasData = data
            completion()
        }
    }
    private func loadIngrediens(completion: @escaping () -> Void ) {
        ServerAPI().loadData(urlString: ServerAPI.Api.ingredients) { [self] (data: [IngredientItem]?) in
            ingrediensData = data
            completion()
        }
    }
    private func mapHomeScreenPizzas() {
        guard let apiPizzasData = apiPizzasData,
              let ingrediensData = ingrediensData else { return }
        defaultPrice = apiPizzasData.basePrice
        let homeScreenPizza: [MyPizza] = mapHomeScreenPizza(pizzas: apiPizzasData.pizzas,
                                                            ingrediens: ingrediensData,
                                                            defaultPrice: defaultPrice)
        pizzasData =  HomeScreenPizzas(pizzas: homeScreenPizza)

    }
    private func mapHomeScreenPizza(pizzas: [Pizza],
                                    ingrediens: [IngredientItem],
                                    defaultPrice: Double) -> [MyPizza] {
        return  pizzas.map { apiPizza in
            MyPizza(name: apiPizza.name,
                    ingredients: apiPizza.ingredients,
                    imageUrl: apiPizza.imageUrl,
                    defaultPrice: defaultPrice,
                    ingredientsText: mapIndrediemsToString(apiPizza.ingredients),
                    customIngredients: apiPizza.ingredients,
                    customPrice: defaultPrice)
        }
    }
    private func mapIndrediemsToString(_ ingrediensInt: [Int64]) -> [String] {
        return  ingrediensInt.map { ingredientCode in
            return ingrediensData?.first(where: {$0.id == ingredientCode})?.name ?? ""
        }
    }
}
