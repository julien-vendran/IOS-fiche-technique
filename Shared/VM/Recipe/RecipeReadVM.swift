//
//  RecipeReadVM.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 01/03/2022.
//

import Foundation
import Combine

class RecipeReadVM : ObservableObject, Subscriber {
    
    
    @Published var steps : [Step]
    @Published var cout : Cost?

    init(step: [Step]){
        self.steps = step
    }
    
    //Activé à chaque send -> Cette partie est utilisée pour la gestion des états de la page (State)
    typealias Input = IntentStateRecipeRead
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive (_ input: IntentStateRecipeRead) -> Subscribers.Demand {
        print("RecipeReadVM -> intent \(input)")
        
        switch input {
        case .ready: //On a rien à faire
            break
        case .load: //Notre view nous demande de charger des données
            break
        case .loading: //On ne le met que si on veut que notre view se mette en "attente d'une réponse"
            break
        case .loaded(let data): //On vient de recevoir nos nouvelles données
            cout = data
        }
        return .none
    }
}
