//
//  IngredientDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation

struct IngredientDTO : Codable{
    var id: Int?
    var name: String
    var unit: String
    var availableQuantity: Int
    var unitPrice: Double
    var associatedAllergen: [AllergenDTO]
    
    var ingredient : Ingredient {
        let allergen_list: [Allergen] = self.associatedAllergen.compactMap {
            (al: AllergenDTO) in
            return al.allergen
        }
        return Ingredient(name: self.name, unit: self.unit, availableQuantity: self.availableQuantity, unitPrice: self.unitPrice, associatedAllergen: allergen_list, denreeUsed: [], id: self.id)
    }
}

struct IngredientDenreeDTO : Codable {
    var id: Int?
    var name: String
    var unit: String
    var availableQuantity: Int
    var unitPrice: Double
 
    
    var ingredient : Ingredient {
        return Ingredient(name: self.name, unit: self.unit, availableQuantity: self.availableQuantity, unitPrice: self.unitPrice, associatedAllergen: [], denreeUsed: [], id: self.id)
    }
}
