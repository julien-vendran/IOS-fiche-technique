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
    case IngredientUpdated(Ingredient?)
    case cancelIngredient
    
    
    var description: String {
        switch self {
        case .ready:
            return "state : .ready" 
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
