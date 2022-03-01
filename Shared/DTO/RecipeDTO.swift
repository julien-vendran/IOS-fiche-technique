//
//  RecipeDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation
/*
 {"parents":{"parents":null,"id":11,"name":"Purée steack","responsable":"Cuisinier ","nbOfCover":4,"category":"Plat pour enfant"},"id":9,"name":"Purée de pomme de terre","responsable":"Cuisinier","nbOfCover":4,"category":"Plat","listOfSteps":[{"parents":null,"id":8,"name":"Préparation de la purée","description":"Faire cuire les pommes de terres à l'eau. Les éplucher. Les écraser","duration":40,"denreeUsed":[{"id":19,"quantity":1,"ingredient":{"id":22,"name":"Pomme de terre","unit":"Kg","availableQuantity":17,"unitPrice":1}}]}]}
 */
struct RecipeDTO: Decodable, Encodable {
    
    var id : Int?
    var name : String
    var responsable : String
    var nbOfCover : Int
    var category : String
    var listOfSteps : [RecipeOrStepDTO]
    //var parents :  RecipeDTO
    
    var recipe: Recipe {
        
        let list_recipe : [RecipeOrStep] = self.listOfSteps.compactMap {
            (dto: RecipeOrStepDTO) -> RecipeOrStep in
                return dto.recipeOrStep
        }
        
        return Recipe(name: self.name, responsable: self.responsable, nbOfCover: self.nbOfCover, category: self.category, listOfStep: list_recipe, id: self.id)
    }
}

struct READRecipeDTO: Decodable, Encodable {
    
    var id : Int?
    var name : String
    var responsable : String
    var nbOfCover : Int
    var category : String
    var listOfSteps : [READRecipeOrStepDTO]
    //var parents :  RecipeDTO
    
    var recipe: Recipe {
        
       /* let list_recipe : [RecipeOrStep] = self.listOfSteps.compactMap {
            (dto: RecipeOrStepDTO) -> RecipeOrStep in
                return dto.recipeOrStep
        }*/
        let list_recipe: [RecipeOrStep] = []
        
        return Recipe(name: self.name, responsable: self.responsable, nbOfCover: self.nbOfCover, category: self.category, listOfStep: list_recipe, id: self.id)
    }
}
