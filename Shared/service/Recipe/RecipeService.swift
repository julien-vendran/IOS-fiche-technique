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
        print("On commence à enregistrer les étapes depuis les recettes (on en a \(recipe.listOfStep.count))")
        let r: Recipe = recipe
        for i in 0..<recipe.listOfStep.count {
            if (recipe.listOfStep[i] is Step) { //C'est une étape donc on veut faire un traitement
                print("On vient de trouver que notre truc est bien une étape")
                let step_tmp: Step? = await StepService.createStep(step: recipe.listOfStep[i] as! Step)
                if (step_tmp != nil) {
                    r.listOfStep[i].id = step_tmp!.id
                    let tmp: Int = r.listOfStep[i].id!
                    print("Mise à jour de recipe.id (\(tmp)")
                } else {
                    //Erreur d'ajout de step
                }
            }
        }
        return r
    }
    
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
    /*
    static func readStepsOfRecipe(id: Int) async -> [Step]{
        var output : [Step] = []
        print("------------------------------")
        do{
            if let url = URL(string:url_back+"\(id)"){
                let decoded : READRecipeOrStepDTO = try await URLSession.shared.getJSON(from: url)
                //Pour chaque element dto on converti, compactMap =map mais plus simple
                if(decoded.isRecipe){
                    print("recipe : \(decoded.id!)")
                    if let recip = await readRecipe(id: decoded.id!){
                        for step in recip.listOfSteps{
                          await  output+=readStepsOfRecipe(id: step.id!)
                        }
                    }
                        
                }else{
                    print("step :  \(decoded.id!)")
                    if let step = await StepService.getStep(id:decoded.id!){
                        output.append(step)
                    }
                }
                
                
            }
        }catch let error{
            print(error)
        }
        print("readStepsOfRecipe \(output)")
        return output
    }
    
    private static func readRecipe(id: Int) async -> READRecipeDTO?{
        var output : READRecipeDTO? = nil
        do{
            if let url = URL(string:url_back+"\(id)"){
                output = try await URLSession.shared.getJSON(from: url)
            }
        }catch let error{
            print(error.localizedDescription)
        }
        return output
    }*/
    
    static func createRecipe(recipe: Recipe) async -> Recipe? {
        print("--------------------------------------------------")
        print("Début de la fonction createRecipe")
        if let url_back = self.url {
            var request = URLRequest(url: url_back)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let new_recipe: Recipe = await RecipeService.saveStepsByRecipe(recipe)
            let tmp: Int = new_recipe.listOfStep[0].id!
            print("Id qu'on enregistre après : \(tmp)")
            let recipe_dto: RecipeDTO = RecipeService.createRecipeDTO(new_recipe)
            
            do {
                let encoded = try JSONEncoder().encode(recipe_dto)
                let addedValue = try await URLSession.shared.upload(for: request, from: encoded)
                let addedRecipe: RecipeDTO? = JSONHelpler.decode(data: addedValue.0)
                print("--------------------------------------------------")
                if (addedRecipe != nil) {
                    return addedRecipe!.recipe
                } else {
                    return nil
                }

            } catch let error {
                print(error)
            }
        }
        return nil
    }
}
