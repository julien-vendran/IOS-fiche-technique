//
//  RecipeCreateStepListVM.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 25/02/2022.
//

import Foundation
import Combine

class RecipeCreateStepListVM: ObservableObject, Subscriber {
    
    @Published var recipeOrStep_list: [RecipeOrStep]
    
    var count: Int {
        return self.recipeOrStep_list.count
    }
    var isEmpty: Bool {
        return self.recipeOrStep_list.count <= 0
    }
    
    init () {
        self.recipeOrStep_list = []
    }
    
    //Fonction utiles
    subscript(index: Int) -> RecipeOrStep { //Redéfinir []
        return self.recipeOrStep_list[index]
    }
    
    func append(_ el: RecipeOrStep) {
        self.recipeOrStep_list.append(el)
    }
    
    //Activé à chaque send -> Cette partie est utilisée pour la gestion des états de la page (State)
    typealias Input = IntentStateRecipeCreate
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive (_ input: Input) -> Subscribers.Demand {
        print("RecipeCreateStepListVM -> intent \(input)")
        
        switch input {
        case .ready: //On a rien à faire
            break
        case .stepAdded(let el):
            self.append(el)
            print(self.recipeOrStep_list)
        case .denreeAdded(_):
            break
        case .cancel:
            self.recipeOrStep_list = []
        }
        return .none
    }
}
