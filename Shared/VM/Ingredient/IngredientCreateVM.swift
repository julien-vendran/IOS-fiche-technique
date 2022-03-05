//
//  IngredientCreateVM.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 27/02/2022.
//

import Foundation


import Foundation
import Combine

class IngredientCreateVM : ObservableObject, Subscriber {
    
    var id: Int?
    @Published var name: String = ""
    @Published var unit: String = ""
    @Published var availableQuantity: Int = 0
    @Published var unitPrice: Double = 0
    @Published var associatedAllergen: [Allergen] = []
        
    init (ingredient_to_update: Ingredient? = nil) {
        if let ingredient: Ingredient = ingredient_to_update {
            self.id = ingredient.id
            self.name = ingredient.name
            self.unit = ingredient.unit
            self.availableQuantity = ingredient.availableQuantity
            self.unitPrice = ingredient.unitPrice
            self.associatedAllergen = ingredient.associatedAllergen
        }
    }
    
    func getStateIngredient (list_allergen allergen: [Allergen]) -> Ingredient {
        return Ingredient(name: self.name, unit: self.unit, availableQuantity: self.availableQuantity, unitPrice: self.unitPrice, associatedAllergen: allergen, denreeUsed: [], id: self.id)
    }
    
    typealias Input = IntentStateIngredientCreate
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive (_ input: Input) -> Subscribers.Demand {
        print("IngredientCreateVM -> intent \(input)")
        
        switch input {
            
        case .ready:
            break
        case .IngredientCreated(let ingredient):
            print(" ingredient creee \(ingredient)")
            if let i = ingredient {
                GlobalInformations.ingredients.append(i)
            }
            //TODO Mettre à jour la liste des ingredients dans la vue principal
        case .IngredientUpdated(let ingredient):
            if let ig: Ingredient = ingredient {
                self.id = ig.id
                self.name = ig.name
                self.unit = ig.unit
                self.availableQuantity = ig.availableQuantity
                self.unitPrice = ig.unitPrice
            }
        case .cancelIngredient:
            self.name = ""
            self.unit = ""
            self.availableQuantity = 0
            self.unitPrice = 0
        }
        
        return .none
    }
}
