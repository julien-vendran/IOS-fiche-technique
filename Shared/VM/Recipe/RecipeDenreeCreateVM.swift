//
//  RecipeDenreeCreateVM.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 28/02/2022.
//

import Foundation
import Combine

class RecipeDenreeCreateVM: ObservableObject, Subscriber {
    
    @Published var denree_list: [Denree]
    
    var count: Int {
        return self.denree_list.count
    }
    var isEmpty: Bool {
        return self.denree_list.count <= 0
    }
    
    init () {
        self.denree_list = []
    }
    
    //Fonction utiles
    subscript(index: Int) -> Denree { //Redéfinir []
        return self.denree_list[index]
    }
    
    func append(_ el: Denree) {
        self.denree_list.append(el)
    }
    
    func setUp(denrees: [Denree]) {
        self.denree_list = []
        for d in denrees {
            print("Ajout d'une denrée : \(d.ingredient!.name)")
            self.append(d)
            print("\(self.denree_list)")
        }
        print("MAJ denrée : \(denrees)")
        print("Nouvelles : \(self.denree_list)")
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
        case .stepAdded(_):
            break
        case .denreeAdded(let denree):
            self.append(denree)
        case .cancel:
            self.denree_list = []
        }
        return .none
    }
}



