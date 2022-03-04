//
//  IntentIngredientCreate.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 27/02/2022.
//

import Foundation
import Combine

enum IntentStateIngredientCreate: CustomStringConvertible {
    case ready
    case loadingAllergen
    case loadedAllergen([Allergen])
    case IngredientCreated(Ingredient)
    case cancelIngredient
    
    
    var description: String {
        switch self {
        case .ready:
            return "state : .ready"
            
        case .IngredientCreated(_) :
            return "state : .ingredientCreated(Data)"
        case .loadingAllergen:
            return "state : .loadingAllergen"
        case .loadedAllergen(_):
            return "state : .loadedAllergen(data)"
        case .cancelIngredient:
            return "state : .cancelIngredient"
        }
    }
}

class IntentIngredientCreate {
    private var state = PassthroughSubject<IntentStateIngredientCreate, Never>()
    
    func addObserver (viewModel: IngredientCreateVM) {
        self.state.subscribe(viewModel)
    }
    
    func intentToCreate(ingredient :Ingredient) async {
        //print(state)
        
        let ig = await IngredientService.saveIngredient(ingredient)
        DispatchQueue.main.async {
            if ig != nil {
                print("Nouvelle Ingredient  : \(ig?.id)")
            }
            self.state.send(.IngredientCreated(ingredient))
        }
        
        self.state.send(.ready)
    }
    func intentToLoad() {
        self.state.send(.loadingAllergen)
        self.state.send(.loadedAllergen(GlobalInformations.allergens))
        self.state.send(.ready)
    }
    
    func intentToCancel() {
        self.state.send(.cancelIngredient)
    }
}
