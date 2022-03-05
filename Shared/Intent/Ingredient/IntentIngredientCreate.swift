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
    case IngredientCreated(Ingredient?)
    case IngredientUpdated(Ingredient?)
    case cancelIngredient
    
    
    var description: String {
        switch self {
        case .ready:
            return "state : .ready"
            
        case .IngredientCreated(_) :
            return "state : .ingredientCreated(Data)"
        case .IngredientUpdated(_):
            return "state : .ingredientUpdated(Data)"
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
    
    func intentToCreate(ingredient: Ingredient) async {
        //print(state)
        
        let ig: Ingredient? = await IngredientService.saveIngredient(ingredient)
        DispatchQueue.main.async {
            self.state.send(.IngredientCreated(ig))
        }
        
        self.state.send(.ready)
    }
    
    func intentToUpdate(_ ingredient: Ingredient) async {
        await IngredientService.updateIngredient(ingredient)
        DispatchQueue.main.async {
            self.state.send(.IngredientUpdated(ingredient))
        }
    }
    
    func intentToCancel() {
        self.state.send(.cancelIngredient)
    }
}
