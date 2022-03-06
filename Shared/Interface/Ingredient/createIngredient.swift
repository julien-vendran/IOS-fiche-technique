//
//  createIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct CreateIngredient: View {
    @ObservedObject var vm : IngredientCreateVM
    var intent : IntentIngredientCreate
    
    @State var allergen : Allergen? = nil
    @State private var selectedAllergen: Int = -1
    var updateMode: Bool
    var ingredient_update: Ingredient?

    let list_Allergen: [Allergen] = GlobalInformations.allergens
    var parent_intent : IntentIngredientList

    var cols = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Environment(\.presentationMode) var presentationMode
    
    init(ingredient_to_update: Ingredient? = nil, parent_intent : IntentIngredientList) {
        self.parent_intent = parent_intent
        self.ingredient_update = ingredient_to_update
        self.updateMode = ingredient_to_update != nil //Si c'est différent de nul alors on veut mettre à jour l'existant
        self.vm = IngredientCreateVM(ingredient_to_update: ingredient_to_update)
        self.intent = IntentIngredientCreate()
        self.intent.addObserver(viewModel: self.vm)
       
    }
    
    var body: some View {
        Form {
            Section(header: Text("Informations générales")) {
                LazyVGrid(columns: cols, alignment: .leading) {
                    Text("Nom :"); TextField("Carotte",text: $vm.name)
                    
                    Text("Unité :"); TextField("kg",text: $vm.unit)
                    
                    Text("Quantité disponible :")
                    HStack {
                        TextField("",value: $vm.availableQuantity, format: .number)
                            .scaledToFit()
                        Text(" \(vm.unit)")
                    }
                    
                    Text("Prix unitaire :")
                    HStack {
                        TextField("",value: $vm.unitPrice,format: .number)
                            .scaledToFit()
                        Text("€")
                    }
                    
                }
            }
            Section (header: Text("Allergènes")) {
                Picker(selection: $selectedAllergen, label: Text("Allergen")) {
                    Text("Aucun allergène").tag(-1)
                    ForEach(0..<self.list_Allergen.count, id:\.self) { id in
                        Text("\(self.list_Allergen[id].name)").tag(id)
                    }
                    .navigationBarTitle("Choix allergènes")
                }.onAppear {
                    if let ingredient: Ingredient = self.ingredient_update {
                        if (ingredient.associatedAllergen.count > 0) {
                            for i in 0..<self.list_Allergen.count {
                                if (ingredient.associatedAllergen[0].name == self.list_Allergen[i].name) {
                                    self.selectedAllergen = i
                                }
                            }
                        }
                    }
                }
            }
            Section(header: Text("Boutons")) {
                Button(action: validate) {
                    if (self.updateMode) {
                        Text("Mettre à jour ingrédient")
                    } else {
                        Text("Créer ingrédient")
                    }
                }
                Button(action: {
                    self.intent.intentToCancel()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text((self.updateMode) ? "Annuler la mise a jour" : "Annuler la création")
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Ajouter ingrédient")
    }
    
    func validate() {
        var allergen: [Allergen]
        if (selectedAllergen == -1) {
            allergen = []
        } else {
            allergen = [self.list_Allergen[selectedAllergen]]
        }
        let ig: Ingredient = self.vm.getStateIngredient(list_allergen: allergen)
        
        if (self.updateMode) {
            Task {
                await intent.intentToUpdate(ig)
                self.intent.intentToCancel()
            }
        } else {
            Task{
                await parent_intent.intentToCreate(ingredient: ig)
                self.intent.intentToCancel()
            }
        }
        presentationMode.wrappedValue.dismiss()
        
    }
}
