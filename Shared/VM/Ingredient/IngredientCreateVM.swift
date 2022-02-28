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
    @Published var associatedAllergen: Set<Allergen> = Set()
    @Published var listAllergen : [Allergen] = []
    //@Published var showAllergen : Bool = false
    
    
    
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
        case .loadingAllergen:
            break
        case .loadedAllergen(let allergens):
            self.listAllergen = allergens
        }
        
        return .none
    }
}
