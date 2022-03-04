//
//  ContentView.swift
//  Shared
//
//  Created by m1 on 10/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group {
            TabView {
                listIngredient()
                    .tabItem {
                        Label(" 🥕 Ingrédients", systemImage: "list.dash")
                    }
                listAllergen()
                    .tabItem {
                        Label("Allergènes", systemImage: "square.and.pencil")
                    }
                ListRecipe()
                    .tabItem {
                        Label("Recettes", systemImage: "pencil.slash")
                    }
            }
        }
        .task {
            GlobalInformations.ingredients = await IngredientService.getAllIngredient()
        }
        .task {
            GlobalInformations.allergens = await AllergenService.getAllallergen()
        }
        .task {
            GlobalInformations.recipes = await RecipeService.getAllRecipe()
        }
        .task {
            GlobalInformations.steps = await StepService.getAllStep()
            for step in GlobalInformations.steps{
                //Ajout des denrée dans les step
                var denree_to_load : [Denree] = []
                for denree in step.denreeUsed {
                    let d = await DenreeService.getDenree(id: denree.id!)
                    if d != nil{
                        denree_to_load.append(d!)
                    }
                }
                step.denreeUsed = denree_to_load
            }
        }
    }
}

struct GlobalInformations {
    static var ingredients: [Ingredient] = []
    static var allergens: [Allergen] = []
    static var recipes: [Recipe] = []
    static var steps : [Step] = []
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
