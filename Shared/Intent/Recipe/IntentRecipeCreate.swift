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
    
    var description: String {
        switch self {
        case .ready:
            return "state : .ready"
        }
    }
}

class IntentRecipeCreate {
    private var state = PassthroughSubject<IntentStateRecipeList, Never>()
    
    func addObserver (viewModel: RecipeListeVM) {
        self.state.subscribe(viewModel)
    }
}
