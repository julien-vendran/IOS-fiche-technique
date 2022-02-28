//
//  createDenree.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct CreateDenree: View {
    var intentDenree: IntentRecipeCreate
    @State var quantity: Double = 0.0
    @State var ingredient_id: Int? = nil
    var ingredients: [Ingredient] = []
    
    var list_ingredients_id: [Int] {
        return []
    }
    
    let col = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(intent: IntentRecipeCreate) {
        self.intentDenree = intent
        Task { //Le passer en paramètre ça sera plus simple
            //self.ingredients = await IngredientService.getAllIngredient()
        }
    }
    var body: some View {
        Form {
            Section(header: Text("Informations")) {
                LazyVGrid(columns: col) {
                    Text("Quantité :")
                    TextField("", value: self.$quantity, format: .number)
                    
                    Text("Ingrédient : ")
                    Picker("", selection: self.$ingredient_id) {
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            Section(header: Text("Boutons")) {
                Button("TEST ajout denrée") {
                    self.intentDenree.intentToCreate(denree: Denree(quantity: self.quantity, ingredient: nil, step: nil, id: nil))
                }
            }
        }
    }
}

/*struct createDenree_Previews: PreviewProvider {
    static var previews: some View {
        createDenree()
    }
}*/
