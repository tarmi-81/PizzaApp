//
//  CommonPizza.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
protocol CommonPizza {
    var name: String { get }
    var ingredients: [Int64] { get }
    var imageUrl: String? { get }
}
