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
    
    var cols = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // @Binding var showingSheet : Bool
    @Environment(\.presentationMode) var presentationMode
    
    init(ingredient_to_update: Ingredient? = nil) {
        self.updateMode = ingredient_to_update != nil //Si c'est différent de nul alors on veut mettre à jour l'existant
        self.vm = IngredientCreateVM(ingredient_to_update: ingredient_to_update)
        self.intent = IntentIngredientCreate()
        self.intent.addObserver(viewModel: self.vm)
        
        if let ingredient: Ingredient = ingredient_to_update {
            print("Mise à jour")
            if (ingredient.associatedAllergen.count > 0) {
                print("TIENS TIENS TIENS")
                for i in 0..<self.vm.listAllergen.count {
                    if (ingredient.associatedAllergen[0].name == self.vm.listAllergen[i].name) {
                        print("Hoplé \(i)")
                        self.selectedAllergen = i
                    }
                }
                
            }
        }
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
                    ForEach(0..<self.vm.listAllergen.count, id:\.self) { id in
                        Text("\(self.vm.listAllergen[id].name)").tag(id)
                    }
                    .navigationBarTitle("Choix allergènes")
                }
            }
            Section(header: Text("Boutons")) {
                Button(action: validate) {
                    Text("Créer ingrédient")
                }
                Button(action: {
                    self.intent.intentToCancel()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Annuler la création")
                }
                .foregroundColor(.red)
            }
        }
        .task {
            // self.listAllergen = await AllergenService.getAllallergen()
            await self.intent.intentToLoad()
            
        }
        .navigationTitle("Ajouter ingrédient")
    }
    
    func validate() {
        var allergen: [Allergen]
        if (selectedAllergen == -1) {
            allergen = []
        } else {
            allergen = [self.vm.listAllergen[selectedAllergen]]
        }
        let ig = Ingredient(name: self.vm.name, unit: self.vm.unit, availableQuantity:self.vm.availableQuantity, unitPrice: self.vm.unitPrice, associatedAllergen: allergen, denreeUsed: [], id: nil)
        
        self.intent.intentToCancel()
        presentationMode.wrappedValue.dismiss()
        Task{
            await intent.intentToCreate(ingredient: ig)
        }
        
    }
}
/*
 struct createIngredient_Previews: PreviewProvider {
 static var previews: some View {
 createIngredient()
 }
 }*/
