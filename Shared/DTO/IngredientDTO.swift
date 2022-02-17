//
//  IngredientDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation
//{"id":7,"name":"Plaque de feuilltage","unit":"Pièce","availableQuantity":150,"unitPrice":0.05,"associatedAllergen":[]}

struct IngredientDTO : Codable{
    var id: Int?
    var name: String
    var unit: String
    var availableQuantity: Int
    var unitPrice: Double
    var associatedAllergen: [AllergenDTO]
    var denreeUsed : [DenreeDTO]?
    
    var ingredient : Ingredient {
        return Ingredient(name: self.name, unit: self.unit, availableQuantity: self.availableQuantity, unitPrice: self.unitPrice, associatedAllergen: [], denreeUsed: [], id: self.id)
    }
    
}
