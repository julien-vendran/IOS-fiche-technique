//
//  ingredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation
class Ingredient {
    var id: Int
    var name: String
    var unit: String
    var availableQuantity: Int?
    var unitPrice: Int?
    var associatedAllergen: Allergen[]
    var denreeUsed: Denree? // Il sert à quoi ça ????? TODO

    constructor(
        name: String?,
        unit: String?,
        availableQuantity: Int?,
        unitPrice: Int?,
        associatedAllergen: Allergen[]?,
        denreeUsed: Denree?,
        id: Int? 
    ) {
        self.id = id
        self.name = name ? name : ""
        self.unit = unit ? unit : ""
        self.availableQuantity = availableQuantity ? availableQuantity : nil
        self.unitPrice = unitPrice ? unitPrice : nil
        self.associatedAllergen = associatedAllergen ? associatedAllergen : []
        self.denreeUsed = denreeUsed ? denreeUsed : nil
    }
}
