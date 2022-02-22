//
//  IngredientService.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import Foundation

class RecipeService {
    
    private static var url = URL(string: "https://fiche-technique-cuisine-back.herokuapp.com/recipe")
    
    static func getAllRecipe() async -> [Recipe] {
        print("Début de la fonction getAllRecipe() de notre service")
        do {
            let decoded : [RecipeDTO] = try await URLSession.shared.getJSON(from: RecipeService.url!)
            
            print("Transformation de notre ingrédient")
            let list_recipe : [Recipe] = decoded.compactMap{ (dto: RecipeDTO) -> Recipe in
                return dto.recipe
            }
            print("On a fini de lire la liste")
            return list_recipe
            
        } catch let error {
                print(error)
        }
        return []
    }
    
}
