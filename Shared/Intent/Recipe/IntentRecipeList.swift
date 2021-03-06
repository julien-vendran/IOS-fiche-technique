//
//  IntentRecipeList.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import Foundation
import Combine
import SwiftUI

enum IntentStateRecipeList: CustomStringConvertible {
    case ready
    case loading
    case load
    case loaded([Recipe])
    
    case loadedStep([Step])
    
    case adding
    case added(Recipe?)
    
    case deleting
    case deleted(Recipe)
    
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
        case .loadedStep(_):
            return "state : .loaddedStep(data)"
        case .deleting:
            return "state : .deleting"
        case .deleted(_):
            return "state : .deleted(data)"
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
        
        DispatchQueue.main.async {
            self.state.send(.loaded(GlobalInformations.recipes))
            self.state.send(.loadedStep(GlobalInformations.steps))
        }
        self.state.send(.ready)
    }
    
    func intentToCreate(recipe: Recipe) async {
        //On va créer notre objet et si tout s'est bien passé, on va recharger la vue
        self.state.send(.adding) //On passe en mode ajout d'une recette
        
        let result: Recipe? = await RecipeService.createRecipe(recipe: recipe)
        DispatchQueue.main.async {
            self.state.send(.added(result))
        }

    }
    
    func intentToDelete(recipe: Recipe) async {
        await RecipeService.deletRecipet(id: recipe.id!)
    }
}
