//
//  DenreeDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation

struct DenreeDTO : Codable {
    var id: Int?
    var quantity: Double
    var ingredient: IngredientDTO?
    var step: StepDTO?
    
    var denree: Denree {
        return Denree(
            quantity: self.quantity,
            ingredient: (self.ingredient != nil) ? self.ingredient!.ingredient : nil,
            step: (self.step != nil) ? self.step!.step : nil, 
            id: self.id)
    }
    
    init (
        quantity: Double,
        ingredient: IngredientDTO?,
        step: StepDTO?,
        id: Int?
    ) {
        self.id = id
        self.quantity = quantity
        self.ingredient = ingredient
        self.step = step
    }
}

struct DenreeReadDTO : Codable {
    var id: Int?
    var quantity: Double
    var ingredient: IngredientDenreeDTO
    
    var denree: Denree {
        return Denree(
            quantity: self.quantity,
            ingredient: self.ingredient.ingredient,
            step: nil,
            id: self.id)
    }
}
