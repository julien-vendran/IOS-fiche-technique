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
  //  var denreeUsed : [DenreeDTO] //TODO: M'expliquer pourquoi il peut être nil. Si ça te fait chier tu balances un tableau vide et ça passe, pas besoin de le mettre à nil parce que ça va obliger à faire des verifs supplémentaires ... -> je pensais que certain ingredient n'avais pas de denreeUsed du tout, donc que il fallait que il y une possibilité d'être à nil. Après un check dans la bd c'est [] et pas nil, donc pas besoin du "?"
    
    var ingredient : Ingredient { //TODO: Gérer l'utilisation des allergènes ^Coucou arnaud^ -> en cousr ouai)
        return Ingredient(name: self.name, unit: self.unit, availableQuantity: self.availableQuantity, unitPrice: self.unitPrice, associatedAllergen: [], denreeUsed: [], id: self.id)
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
