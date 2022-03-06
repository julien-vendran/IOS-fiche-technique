//
//  ContentView.swift
//  Shared
//
//  Created by m1 on 10/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State var ingredient: Bool = false
    @State var allergen: Bool = false
    @State var recipe: Bool = false
    @State var step: Bool = false

    var body: some View {
        Group {
            if (ingredient && allergen && recipe && step) {
                TabView {
                    ListRecipe()
                        .tabItem {
                            Label("Recettes", systemImage: "pencil.slash")
                        }
                    listIngredient()
                        .tabItem {
                            Label("Ingrédients", systemImage: "list.dash")
                        }
                    listAllergen()
                        .tabItem {
                            Label("Allergènes", systemImage: "square.and.pencil")
                        }
                }
            } else {
                Text("Chargement de l'application ...")
                    .font(.title)
                ProgressView()
            }
        }
        .task {
            GlobalInformations.ingredients = await IngredientService.getAllIngredient()
            print("------------------------------")
            print(GlobalInformations.ingredients[0].id)
            self.ingredient = true
        }
        .task {
            GlobalInformations.allergens = await AllergenService.getAllallergen()
            self.allergen = true
        }
        .task {
            GlobalInformations.recipes = await RecipeService.getAllRecipe()
            self.recipe = true
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
            self.step = true
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
