//
//  readRecipe.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 23/02/2022.
//

import SwiftUI

enum Informations_tab: String, CustomStringConvertible, CaseIterable, Identifiable {
    case ingredient
    case autre
    var id: Self {self}
    
    var description: String {
        switch self {
        case .ingredient:
            return "Ingrédients"
        case .autre:
            return "Autre"
        }
    }
}

struct ReadRecipe: View {
    var recipe: Recipe
    @State var currentTab: Informations_tab = .ingredient

    var body: some View {
        VStack() {
            Text("\(recipe.name)")
                .font(.title)
            Picker("", selection: $currentTab) {
                ForEach(Informations_tab.allCases) { info in
                    Text(info.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }.padding()
    }
}

struct readRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ReadRecipe(
            recipe: Recipe(name: "Purée de pomme de terre", responsable: "Cuisinier", nbOfCover: 10, category: "Plat", listOfStep: [], id: 1)
        )
    }
}
