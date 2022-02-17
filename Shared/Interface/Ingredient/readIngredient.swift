//
//  readIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import SwiftUI

struct ReadIngredient: View {
    @State var ingredient: Ingredient
    
    init (ingredient : Ingredient) {
        self.ingredient = ingredient
    }
    var body: some View {
        VStack {
            Text("Nom :"); Text("\(ingredient.name)")
            Text("Unité :"); Text("\(ingredient.unit)")
            Text("Quantité disponible"); Text("\(ingredient.availableQuantity)")
            Text("Prix unitaire"); Text("\(ingredient.unitPrice)")
        }
        .navigationTitle("\(ingredient.name)")
       
    }
}

/*struct readIngredient_Previews: PreviewProvider {
    static var previews: some View {
        ReadIngredient(ingredient: Ingredient(name: "Patate", unit: "kg", availableQuantity: 20, unitPrice: 2, associatedAllergen: [], denreeUsed: Denree(), id: nil))
    }
}*/
