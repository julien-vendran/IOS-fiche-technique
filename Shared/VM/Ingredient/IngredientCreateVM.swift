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
    
    
    @Published var name: String = ""
    @Published var unit: String = ""
    @Published var availableQuantity: Int = 0
    @Published var unitPrice: Double = 0
    @Published var associatedAllergen: [Allergen] = []
    @Published var listAllergen : [Allergen] = []
        
    init (ingredient_to_update: Ingredient? = nil) {
        if let ingredient: Ingredient = ingredient_to_update {
            self.name = ingredient.name
            self.unit = ingredient.unit
            self.availableQuantity = ingredient.availableQuantity
            self.unitPrice = ingredient.unitPrice
            self.associatedAllergen = ingredient.associatedAllergen
        }
    }
    
    typealias Input = IntentStateIngredientCreate
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive (_ input: IntentStateIngredientCreate) -> Subscribers.Demand {
        print("IngredientCreateVM -> intent \(input)")
        
        switch input {
            
        case .ready:
            break
        case .IngredientCreated(let ingredient):
            print(" ingredient creee \(ingredient)")
            //TODO Mettre à jour la liste des ingredients dans la vue principal
        case .loadingAllergen:
            break
        case .loadedAllergen(let allergens):
            self.listAllergen = allergens
        case .cancelIngredient:
            self.name = ""
            self.unit = ""
            self.availableQuantity = 0
            self.unitPrice = 0
        }
        
        return .none
    }
}
