//
//  readRecipe.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 23/02/2022.
//

import SwiftUI

struct ReadRecipe: View {
    var recipe: Recipe
    
    var body: some View {
        VStack() {
            Text("\(recipe.name)")
                .font(.title)
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
