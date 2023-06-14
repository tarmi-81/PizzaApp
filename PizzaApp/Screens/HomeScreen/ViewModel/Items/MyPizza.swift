//
//  HomeScreenPizza.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 11/06/2023.
//

import Foundation
struct MyPizza: CommonPizza {
    let name: String
    let ingredients: [Int64]
    let imageUrl: String?
    let defaultPrice: Double
    var ingredientsText: [String]
    var customIngredients: [Int64]
    var customPrice: Double
    var id: UUID?
}
