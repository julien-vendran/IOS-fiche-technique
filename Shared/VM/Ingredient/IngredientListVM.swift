//
//  IngredientListVM.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 26/02/2022.
//

import Foundation
import Combine

class IngredientListVM : ObservableObject, Subscriber {
    
    @Published var ingredient_list: [Ingredient]
    
    var count: Int {
        return self.ingredient_list.count
    }
    var isEmpty: Bool {
        return self.ingredient_list.count <= 0
    }
    
    init (ingredient: [Ingredient]) {
        self.ingredient_list = ingredient
    }
    
    //Fonction utiles
    subscript(index: Int) -> Ingredient { //Redéfinir []
        return self.ingredient_list[index]
    }
    
    func remove(atOffsets: IndexSet) -> [Ingredient]{
        var output : [Ingredient] = []
        for i in atOffsets.makeIterator() {
            output.append(ingredient_list[i])
           }
        self.ingredient_list.remove(atOffsets: atOffsets)
        return output
    }
    
    func move(fromOffsets: IndexSet, toOffset: Int){
        self.ingredient_list.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
     
    typealias Input = IntentStateIngredientList
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive (_ input: IntentStateIngredientList) -> Subscribers.Demand {
        print("IngredientListVM -> intent \(input)")
        
        switch input {
        case .ready: //On a rien à faire
            break
        case .load: //Notre view nous demande de charger des données
            break
        case .loading: //On ne le met que si on veut que notre view se mette en "attente d'une réponse"
            break
        case .loaded(let data): //On vient de recevoir nos nouvelles données
            self.ingredient_list = data
          case .adding: //on est en cours d'ajout
            break
        case .added(let ingredient):
            if (ingredient != nil) {
                print(ingredient!)
                self.ingredient_list.append(ingredient!)
            } else { //Erreur dans l'ajout de notre ingredient
                print("Erreur dans la création de l'ingredient'")
            }
        case .deleting:
            break
        case .deleted(let ingredient):
            print("Suppression de l'ingredient \(ingredient.name)")
        }
        return .none
    }
}

