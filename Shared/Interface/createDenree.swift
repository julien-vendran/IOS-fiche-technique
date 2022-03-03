//
//  createDenree.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct CreateDenree: View {
    var intentDenree: IntentRecipeCreate
    var denreeToUpdate: Denree?
    var updateMode: Bool = false
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
    
    init(intent: IntentRecipeCreate, denreeToUpdate: Denree? = nil) {
        self.intentDenree = intent
        self.denreeToUpdate = denreeToUpdate
        if (self.denreeToUpdate != nil) {
            self.updateMode = true //On va utiliser cette variable pour savoir qu'on veut modifier et par créer
        }
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
                Picker("Ingrédient", selection: self.$ingredient_id, content: {
                    ForEach(0..<self.ingredients.count, id:\.self) { id in
                        Text("\(self.ingredients[id].name)").tag(id)
                    }
                })
                .pickerStyle(WheelPickerStyle())
                .padding(1)
            }
            Section(header: Text("Boutons")) {
                if (!self.updateMode) { //on veut ajouter
                    Button("Ajouter l'ingrédient") {
                        print("id : \(self.ingredient_id)")
                        self.intentDenree.intentToCreate(denree: Denree(quantity: self.quantity, ingredient: self.ingredients[self.ingredient_id], step: nil, id: nil))
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    Button("Mettre à jour l'ingrédient") {
                        self.denreeToUpdate?.ingredient = self.ingredients[self.ingredient_id]
                        self.denreeToUpdate?.quantity = self.quantity
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                Button((self.updateMode) ? "Annuler la mise à jour" : "Annuler l'ajout") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)
            }
        }
        .task {
            //TODO: Le passer en paramètre ce sera mieux
            self.ingredients = await IngredientService.getAllIngredient()
            self.ingredients = self.ingredients.sorted(by: {$0.name < $1.name})
            
            if (self.updateMode) { //Si on met à jour un ingrédient, on veut lui pré-remplir les champs
                for i in 0..<self.ingredients.count {
                    if (self.ingredients[i].name == self.denreeToUpdate?.ingredient!.name) {
                        self.ingredient_id = i
                    }
                }
                self.quantity = self.denreeToUpdate?.quantity ?? 0
            }
        }
        .navigationTitle((self.updateMode) ? "Mise à jour d'un ingrédient" : "Ajout d'un ingrédient")
    }
}

struct createDenree_Previews: PreviewProvider {
    static var previews: some View {
        CreateDenree(intent: IntentRecipeCreate())
    }
}
