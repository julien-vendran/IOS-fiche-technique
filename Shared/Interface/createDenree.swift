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
    @State private var ingredient_id: Int = 0
    @State var ingredients: [Ingredient] = []
    
    @Environment(\.presentationMode) var presentationMode
    
    var list_ingredients_id: [Int] {
        return [1, 2, 3]
    }
    
    let col = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(intent: IntentRecipeCreate) {
        self.intentDenree = intent
    }
    var body: some View {
        Form {
            Section(header: Text("Informations")) {
                LazyVGrid(columns: col, alignment: .leading) {
                    Text("Quantité :")
                    HStack {
                        TextField("", value: self.$quantity, format: .number)
                        if (self.ingredients.count > 0 && self.ingredient_id >= 0 && self.ingredient_id < self.ingredients.count) {
                            Text("\(self.ingredients[ingredient_id].unit)")
                        }
                    }
                }
                Text("Ingrédient : ")
                Picker("Ingrédien", selection: self.$ingredient_id, content: {
                    ForEach(0..<self.ingredients.count, id:\.self) { id in
                        Text("\(self.ingredients[id].name)").tag(id)
                    }
                })
                .pickerStyle(WheelPickerStyle())
                .padding(1)
            }
            Section(header: Text("Boutons")) {
                Button("Ajouter l'ingrédient") {
                    self.intentDenree.intentToCreate(denree: Denree(quantity: self.quantity, ingredient: self.ingredients[self.ingredient_id], step: nil, id: nil))
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Annuler l'ajout") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)
            }
        }
        .task {
            //TODO: Le passer en paramètre ce sera mieux
            self.ingredients = await IngredientService.getAllIngredient()
            self.ingredients = self.ingredients.sorted(by: {$0.name < $1.name})
        }
        .navigationTitle("Ajout d'un ingrédient")
    }
}

struct createDenree_Previews: PreviewProvider {
    static var previews: some View {
        CreateDenree(intent: IntentRecipeCreate())
    }
}
