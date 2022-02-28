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
        }
    }
}

class IntentIngredientCreate {
    private var state = PassthroughSubject<IntentStateIngredientCreate, Never>()
    
    func addObserver (viewModel: IngredientCreateVM) {
        self.state.subscribe(viewModel)
    }
    
    func intentToCreate(ingredient :Ingredient) {
        //print(state)
        self.state.send(.IngredientCreated(ingredient))
        
        self.state.send(.ready)
    }
    func intentToLoad() async {
        self.state.send(.loadingAllergen)
        let data: [Allergen] = await AllergenService.getAllallergen()
        DispatchQueue.main.async {
            self.state.send(.loadedAllergen(data))
        }
        self.state.send(.ready)
    }
}
