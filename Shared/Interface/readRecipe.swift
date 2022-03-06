//
//  readRecipe.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 23/02/2022.
//

import SwiftUI

enum Informations_tab: String, CustomStringConvertible, CaseIterable, Identifiable {
    case ingredient
    case description
    case cout
    var id: Self {self}
    
    var description: String {
        switch self {
        case .ingredient:
            return "Ingrédients"
        case .description:
            return "Description"
        case .cout :
            return "Coûts"
        }
    }
}

struct ReadRecipe: View {

    var recipe: Recipe
    @State var currentTab: Informations_tab = .ingredient
    @ObservedObject var vm : RecipeReadVM
    
    var intent : IntentRecipeRead

    init(recipe: Recipe){
        self.recipe = recipe
        self.vm = RecipeReadVM(step: recipe.getSteps())
        self.intent = IntentRecipeRead()
        self.intent.addObserver(viewModel: self.vm)
    }
    var body: some View {
        VStack() {
            Picker("", selection: $currentTab) {
                ForEach(Informations_tab.allCases) { info in
                    Text(info.description)
                }
            }
            .pickerStyle(.segmented)
            if case currentTab = Informations_tab.cout{
                Cout(cout: vm.cout)
            } else if case currentTab = Informations_tab.ingredient {
                RecapIngredient(recipe: self.recipe)
            } else {
                List {
                    ForEach((0..<self.vm.steps.count), id: \.self) { i in
                        if case currentTab.id = Informations_tab.description{
                            ReadStep(step: self.vm.steps[i], i: i)
                        }
                    }
                }
            }
        }.task {
            await intent.intentToLoad(idRecipe: recipe.id!)
        }
        .padding()
        .navigationTitle("\(recipe.name)")
        
    }
}

struct readRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ReadRecipe(
            recipe: Recipe(name: "Purée de pomme de terre", responsable: "Cuisinier", nbOfCover: 10, category: "Plat", listOfStep: [], id: 1)
        )
    }
}
