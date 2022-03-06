//
//  IntentListIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation
import Combine
enum IntentStateIngredientList: CustomStringConvertible {
    case ready
    case loading
    case load
    case loaded([Ingredient])
    
    case adding
    case added(Ingredient?)
    
    case deleting
    case deleted(Ingredient)
    
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
        case .adding:
            return "state : .adding"
        case .added(_):
            return "state : .added"
        case .deleting:
            return "state : .deleting"
        case .deleted(_):
            return "state : .deleted(data)"
        }
    }
}

class IntentIngredientList {
    private var state = PassthroughSubject<IntentStateIngredientList, Never>()
    
    func addObserver (viewModel: IngredientListVM) {
        self.state.subscribe(viewModel)
    }
    
    func intentToLoad() {
        self.state.send(.loading)
        self.state.send(.loaded(GlobalInformations.ingredients))
        self.state.send(.ready)
    }
      
    func intentToCreate(ingredient: Ingredient) async {
   
        self.state.send(.adding)
        let result: Ingredient? = await IngredientService.saveIngredient(ingredient)
        self.state.send(.added(result))
    }
    
    func intentToDelete(ingredient: Ingredient) async {
        self.state.send(.deleting)
        await IngredientService.deletIngredient(id: ingredient.id!)
        self.state.send(.deleted(ingredient))
    }
}
