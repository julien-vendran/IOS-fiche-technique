//
//  IntentRecipeList.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import Foundation
import Combine

enum IntentStateRecipeList: CustomStringConvertible {
    case ready
    case loading
    case load
    case loaded([Recipe])
    
    var description: String {
        switch self {
        case .ready:
            return "state : .ready"
        case .loading:
            return "state : .loading"
        case .load:
            return "state : .load"
        case .loaded(_):
            return "state : .loaded(Data)"
        }
    }
}

class IntentRecipeList {
    private var state = PassthroughSubject<IntentStateRecipeList, Never>()
    
    func addObserver (viewModel: RecipeListeVM) {
        self.state.subscribe(viewModel)
    }
    
    func intentToLoad() async {
        self.state.send(.loading)
        let data: [Recipe] = await RecipeService.getAllRecipe()
        self.state.send(.loaded(data))
    }
}
