//
//  IngredientService.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import Foundation

class RecipeService {
    private static var url_back = "https://fiche-technique-cuisine-back.herokuapp.com/recipe/"
    private static var url = URL(string: url_back)
    
    static func createRecipeDTO (_ recipe: Recipe) -> RecipeDTO {
        let list_recipe_or_step: [RecipeOrStepDTO] = recipe.listOfStep.compactMap {
            (r: RecipeOrStep) -> RecipeOrStepDTO in
            return RecipeOrStepDTO(id: r.id, name: r.name)
        }
        
        let recipe_dto: RecipeDTO = RecipeDTO(id: recipe.id, name: recipe.name, responsable: recipe.responsable, nbOfCover: recipe.nbOfCover, category: recipe.category, listOfSteps: list_recipe_or_step)
        return recipe_dto
    }
    
    /**
     Enregistre les steps en BD puis retourne une Recipe avec les id pour les Steps
     */
    static func saveStepsByRecipe(_ recipe: Recipe) async -> Recipe {
        let r: Recipe = recipe
        for i in 0..<recipe.listOfStep.count {
            if (recipe.listOfStep[i] is Step) { //C'est une étape donc on veut faire un traitement
                let step_tmp: Step? = await StepService.createStep(step: recipe.listOfStep[i] as! Step)
                if (step_tmp != nil) {
                    r.listOfStep[i] = step_tmp!
                } else {
                    //Erreur d'ajout de step
                }
            }
        }
        return r
    }
    
    static func getAllRecipe() async -> [Recipe] {
        do {
            let decoded : [RecipeDTO] = try await URLSession.shared.getJSON(from: RecipeService.url!)
            let list_recipe : [Recipe] = decoded.compactMap{ (dto: RecipeDTO) -> Recipe in
                return dto.recipe
            }
            return list_recipe
            
        } catch let error {
            print(error)
        }
        return []
    }
    
    static func getCostOfRecipe(IdRecipe: Int) async -> Cost? {
        var output : Cost? = nil
        do{
            if let url = URL(string: url_back+"cost/\(IdRecipe)"){
                let decoded : CostDTO = try await URLSession.shared.getJSON(from: url)
                output = decoded.cout
            }
        }catch let error{
            print(error)
        }
        return output
        
    }
    
    
    static func createRecipe(recipe: Recipe) async -> Recipe? {
        if let url_back = self.url {
            var request = URLRequest(url: url_back)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let new_recipe: Recipe = await RecipeService.saveStepsByRecipe(recipe)
            let recipe_dto: RecipeDTO = RecipeService.createRecipeDTO(new_recipe)
            
            do {
                let encoded = try JSONEncoder().encode(recipe_dto)
                let addedValue = try await URLSession.shared.upload(for: request, from: encoded)
                let addedRecipe: RecipeDTO? = JSONHelpler.decode(data: addedValue.0)
                if (addedRecipe != nil) {
                    let recipe_created = addedRecipe!.recipe
                    recipe_created.listOfStep = new_recipe.listOfStep
                    return recipe_created
                } else {
                    return nil
                }
                
            } catch let error {
                print(error)
            }
        }
        return nil
    }
    
    public static func deletRecipet(id: Int) async {
        if let url = URL(string: url_back+"\(id)"){
            var request = URLRequest(url: url)
            request.httpMethod="DELETE"
            do{
                let _ = try await URLSession.shared.data(for: request)
                
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    public static func sellRecipe(id: Int) async {
        if let url_sell: URL = URL(string: "\(self.url_back)sellRecipe/\(id)") {
            do {
                let _ : [RecipeDTO] = try await URLSession.shared.getJSON(from: url_sell)
            } catch let error {
                print(error)
            }
        }
    }
    
}
