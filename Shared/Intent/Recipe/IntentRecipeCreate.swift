//
//  IntentRecipeCreate.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 25/02/2022.
//

import Foundation
import Combine

enum IntentStateRecipeCreate: CustomStringConvertible {
    case ready
    case stepAdded(Step)
    case denreeAdded(Denree)
    
    var description: String {
        switch self {
        case .ready:
            return "state : .ready"
        case .stepAdded(_):
            return "state : .stepAdded(Data)"
        case .denreeAdded(_):
            return "state : .denreeAdded(Data)"
        }

    }
}

class IntentRecipeCreate {
    private var state = PassthroughSubject<IntentStateRecipeCreate, Never>()
    
    func addObserver (viewModel: RecipeCreateStepListVM) {
        self.state.subscribe(viewModel)
    }
    func addObserver (viewModel: RecipeDenreeCreateVM) {
        self.state.subscribe(viewModel)
    }
    
    func intentToCreate(step: Step) {
        //print(state)
        self.state.send(.stepAdded(step))
        
        self.state.send(.ready)
    }
    
    func intentToCreate(denree: Denree) {
        self.state.send(.denreeAdded(denree))
        
        self.state.send(.ready)
    }
}
