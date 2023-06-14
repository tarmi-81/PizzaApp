//
//  DrinksViewModel.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 14/06/2023.
//

import Foundation

final class DrinksViewModel {
    var drinksData: [DrinkItem]?
    func loadData(completion: @escaping () -> Void ) {
        loadDrinks {
            completion()
        }
    }
    private func  loadDrinks(completion: @escaping () -> Void ) {
        ServerAPI().loadData(urlString: ServerAPI.Api.drinks) {  [self] (data: [DrinkItem]?) in
            drinksData = data
            completion()
        }
    }
}
