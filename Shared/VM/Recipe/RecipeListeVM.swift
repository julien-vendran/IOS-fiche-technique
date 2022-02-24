//
//  RecipeListeVM.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import Foundation
import Combine

class RecipeListeVM: ObservableObject, Subscriber {
    
    @Published var associated_recipe_list: [Recipe]
    
    var count: Int {
        return self.associated_recipe_list.count
    }
    var isEmpty: Bool {
        return self.associated_recipe_list.count <= 0
    }
    
    init (recipe: [Recipe]) {
        self.associated_recipe_list = recipe
    }
    
    //Fonction utiles
    subscript(index: Int) -> Recipe { //Redéfinir []
        return self.associated_recipe_list[index]
    }
    
    //Activé à chaque send -> Cette partie est utilisée pour la gestion des états de la page (State)
    typealias Input = IntentStateRecipeList
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive (_ input: IntentStateRecipeList) -> Subscribers.Demand {
        print("RecipeListVM -> intent \(input)")
        
        switch input {
        case .ready: //On a rien à faire
            break
        case .load: //Notre view nous demande de charger des données
            break
        case .loading: //On ne le met que si on veut que notre view se mette en "attente d'une réponse"
            break
        case .loaded(let data): //On vient de recevoir nos nouvelles données
            self.associated_recipe_list = data
            print("On vient d'affecter nos données")
            print(self.associated_recipe_list)
        case .adding: //on est en cours d'ajout
            break
        case .added(_):
            break
        }
        return .none
    }
}
