//
//  Item.swift
//  shoppingList
//
//  Created by MILES RICHMOND on 10/31/23.
//

import Foundation

struct Item: Codable {
    var section: FoodType
    var name: String
    var color: String
}

enum FoodType: Codable {
    case produce
    case frozen
    case deli
    case none
}
