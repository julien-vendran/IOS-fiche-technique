//
//  denree.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//

import Foundation

class Denree {
    
    var id: Int?
    var quantity: Double
    var ingredient: Ingredient?
    var step: Step?
    
    init (
        quantity qte: Double,
        ingredient ingre: Ingredient?,
        step: Step?,
        id: Int?
    ) {
        self.id = id
        self.quantity = qte
        self.ingredient = ingre
        self.step = step
    }
}
