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
    @Published var step_list : [Step]
    var count: Int {
        return self.associated_recipe_list.count
    }
    var isEmpty: Bool {
        return self.associated_recipe_list.count <= 0
    }
    
    init (recipe: [Recipe]) {
        self.associated_recipe_list = recipe
        self.step_list = []
    }
    
    func removeRecipes(atOffsets: IndexSet) -> [Recipe]{
        var output : [Recipe] = []
        for i in atOffsets.makeIterator() {
            output.append(associated_recipe_list[i])
           }
        self.associated_recipe_list.remove(atOffsets: atOffsets)
        return output
    }
    
    func moveRecipes(fromOffsets: IndexSet, toOffset: Int){
        self.associated_recipe_list.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    //Fonction utiles
    subscript(index: Int) -> Recipe { //Redéfinir []
        return self.associated_recipe_list[index]
    }
    
    typealias Input = IntentStateRecipeList
    
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive (_ input: Input) -> Subscribers.Demand {
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

        case .adding: //on est en cours d'ajout
            break

        case .added(let recipe):
            if (recipe != nil) {
                print(recipe!)
                self.associated_recipe_list.append(recipe!)
                GlobalInformations.recipes.append(recipe!)
            } else { //Erreur dans l'ajout de notre recette
                print("Erreur dans la création de la recette")
            }
        case .loadedStep(let data):
            self.step_list = data
            if (step_list.isEmpty==false && associated_recipe_list.isEmpty==false) {
                buildRecipe()
                print(associated_recipe_list[0].listOfStep)
            }
        case .deleting:
            break
        case .deleted(let recipe):
            print("Suppression de  la recette \(recipe.name)")
        }
        return .none
    }
    
    private func find(id : Int) -> RecipeOrStep? {
        if let recipe = findRecipe(id: id){
            return recipe
        }
        else if let step = findStep(id: id){
            return step
        }
        return nil
    }
    
    private func findRecipe(id: Int) -> Recipe?{
        
        for r in associated_recipe_list {
            if r.id == id {
                return r
            }
        }
        return nil
    }
    
    private func findStep(id: Int) -> Step?{
        for s in step_list {
            if s.id == id {
                return s
            }
        }
        return nil
    }
    
    private func buildRecipe(){
        for recette in associated_recipe_list{
            for i in 0...recette.listOfStep.count-1{
                if let recipeOrStep = find(id: recette.listOfStep[i].id!){
                    recette.listOfStep[i] = recipeOrStep
                }
            }
        }
    }
}
