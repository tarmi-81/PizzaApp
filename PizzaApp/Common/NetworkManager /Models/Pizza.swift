//
//  Pizza.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation

struct Pizza: Codable, CommonPizza {
    let name: String
    let ingredients: [Int64]
    let imageUrl: String?
}
