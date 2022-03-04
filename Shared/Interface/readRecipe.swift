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
            return "Cout"
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
            Text("\(recipe.name)")
                .font(.title)
            if case currentTab = Informations_tab.cout{
                Cout(cout: vm.cout)
            }else{
                List {
                    ForEach((0..<self.vm.steps.count), id: \.self) { i in
                        
                        if case currentTab = Informations_tab.ingredient{
                            ReadStep(step: self.vm.steps[i])
                        }
                        
                        if case currentTab.id = Informations_tab.description{
                            Section(header: Text(vm.steps[i].name)){
                                Text("\(vm.steps[i].description)")
                            }
                        }
                        
                    }
                }
            }
            HStack{
             
            Picker("", selection: $currentTab) {
                ForEach(Informations_tab.allCases) { info in
                    Text(info.rawValue)
                }
            }
            .pickerStyle(.segmented)
                
            }
            .frame(height: 40)
            
        
        }.task {
           await intent.intentToLoad(idRecipe: recipe.id!)
        }
        .padding()
        
    }
}

struct readRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ReadRecipe(
            recipe: Recipe(name: "Purée de pomme de terre", responsable: "Cuisinier", nbOfCover: 10, category: "Plat", listOfStep: [], id: 1)
        )
    }
}
