//
//  StepReadVM.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 02/03/2022.
//


import Foundation
import Combine

class StepReadVM : ObservableObject, Subscriber {
    
    @Published var step : Step
    @Published var denrees : [Denree]
    
    init(step : Step) {
        self.step = step
         denrees = step.denreeUsed
    }
    
    //Activé à chaque send -> Cette partie est utilisée pour la gestion des états de la page (State)
    typealias Input = IntentStateStepRead
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive (_ input: IntentStateStepRead) -> Subscribers.Demand {
      //  print("StepReadVM -> intent \(input)")
        
        switch input {
        case .ready: //On a rien à faire
            break
        case .load: //Notre view nous demande de charger des données
            break
        case .loading: //On ne le met que si on veut que notre view se mette en "attente d'une réponse"
            break
        case .loaded(let data): //On vient de recevoir nos nouvelles données
            
            self.step.denreeUsed = data
     
            //self.denrees = data
            
        }
        return .none
    }
}
