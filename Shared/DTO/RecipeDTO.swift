//
//  RecipeDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation

struct RecipeDTO: Decodable, Encodable {
    
    var id : Int?
    var name : String
    var responsable : String
    var nbOfCover : Int
    var category : String
    var listOfSteps : [RecipeOrStepDTO]
    
    var recipe: Recipe {
        let list_recipe : [RecipeOrStep] = self.listOfSteps.compactMap {
            (dto: RecipeOrStepDTO) -> RecipeOrStep in
                return dto.recipeOrStep
        }
        
        return Recipe(name: self.name, responsable: self.responsable, nbOfCover: self.nbOfCover, category: self.category, listOfStep: list_recipe, id: self.id)
    }
}
