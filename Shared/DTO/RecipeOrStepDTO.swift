//
//  RecipeOrStepDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import Foundation

struct RecipeOrStepDTO: Decodable, Encodable {
    var id: Int?
    var name: String
    
    var recipeOrStep: RecipeOrStep {
        return RecipeOrStep(name: self.name, id: id)
    }
}
