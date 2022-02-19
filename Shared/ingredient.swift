//
//  ingredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation
class Ingredient :Identifiable {
    var id: Int?
    var name: String
    var unit: String
    var availableQuantity: Int
    var unitPrice: Double
    var associatedAllergen: [Allergen]
    var denreeUsed: [Denree] // Il sert à quoi ????? TODO

    init (
        name: String,
        unit: String,
        availableQuantity: Int,
        unitPrice: Double,
        associatedAllergen: [Allergen],
        denreeUsed: [Denree],
        id: Int? 
    ) {
        self.id = id
        self.name = name
        self.unit = unit
        self.availableQuantity = availableQuantity
        self.unitPrice = unitPrice
        self.associatedAllergen = associatedAllergen
        self.denreeUsed = denreeUsed
    }
}
