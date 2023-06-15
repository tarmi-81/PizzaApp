//
//  IngrediensSelectItem.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation

struct IngredientsSelectItem: CommonItem {
    var id: Int64
    var name: String
    var price: Double
    var isSelected: Bool = false
}
