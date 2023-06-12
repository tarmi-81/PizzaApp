//
//  CommonItem.swift
//  PizzaApp
//
//  Created by Jozef Gmuca on 12/06/2023.
//

import Foundation
protocol CommonItem {
    var id: Int64 { get set }
    var name: String { get set }
    var price: Double { get set }
}
struct Item: Codable, CommonItem {
    var id: Int64
    var name: String
    var price: Double
}
