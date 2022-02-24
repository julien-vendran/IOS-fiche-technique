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
    
    case adding
    case added(Recipe)
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
        DispatchQueue.main.async {
            self.state.send(.loaded(data))
        }
        self.state.send(.ready)
    }
    
    func intentToCreate(recipe: Recipe) async {
        //On va créer notre objet et si tout s'est bien passé, on va recharger la vue
        self.state.send(.adding) //On passe en mode ajout d'une recette
        
        await RecipeService.createRecipe(recipe: recipe)
        
        self.state.send(.added(recipe))
        
        await self.intentToLoad()
    }
}
