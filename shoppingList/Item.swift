//
//  Item.swift
//  shoppingList
//
//  Created by MILES RICHMOND on 10/31/23.
//

import Foundation

struct Item {
    var section: FoodType
    var name: String
    var cost: Double
}

enum FoodType {
    case produce
    case frozen
    case deli
}
