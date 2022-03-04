//
//  IntentRecipeRead.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 01/03/2022.
//

import Foundation
import Combine

enum IntentStateRecipeRead: CustomStringConvertible {
    case ready
    case loading
    case load
    case loaded(Cost)
    

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

class IntentRecipeRead {
    private var state = PassthroughSubject<IntentStateRecipeRead, Never>()
    private var steps_list : [Step] = []
    func addObserver (viewModel: RecipeReadVM) {
        self.state.subscribe(viewModel)
    }
    
    func intentToLoad(idRecipe: Int) async {
        self.state.send(.loading)
        if let cout = await RecipeService.getCostOfRecipe(IdRecipe: idRecipe){
            DispatchQueue.main.async {
                self.state.send(.loaded(cout))
            }
        }

        self.state.send(.ready)
    }
    
    
    
    
 
}
