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
    
    
    var description: String {
        switch self {
        case .ready:
            return "state : .ready"
        case .stepAdded(_):
            return "state : .stepCreated(Data)"
        }
    }
}

class IntentRecipeCreate {
    private var state = PassthroughSubject<IntentStateRecipeCreate, Never>()
    
    func addObserver (viewModel: RecipeCreateStepListVM) {
        self.state.subscribe(viewModel)
    }
    
    func intentToCreate(step: Step) {
        //print(state)
        self.state.send(.stepAdded(step))
        
        self.state.send(.ready)
    }
}
