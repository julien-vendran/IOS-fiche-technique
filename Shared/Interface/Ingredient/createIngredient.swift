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
    @State private var selectedAllergen: Int = 0
    
    var cols = [
        GridItem(.fixed(120)),
        GridItem(.flexible())
    ]
    
    // @Binding var showingSheet : Bool
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        self.vm = IngredientCreateVM()
        self.intent = IntentIngredientCreate()
        self.intent.addObserver(viewModel: self.vm)
    }
    
    
    var body: some View {
        Form {
            Section(header: Text("Informations générales")) {
                LazyVGrid(columns: cols, alignment: .leading) {
                    Group{
                        Text("Nom :"); TextField("nom ingredient",text: $vm.name)
                    }
                    Group{
                        Text("Unité :"); TextField("unité",text: $vm.unit)
                    }
                    Group{
                        Text("Quantité disponible :"); TextField("",value: $vm.availableQuantity, formatter: NumberFormatter())
                    }
                    Group{
                        Text("Prix unitaire :"); TextField("",value: $vm.unitPrice,formatter: NumberFormatter())
                    }
                    
                }
            }
            Section (header: Text("Allergènes")) {
                Picker(selection: $selectedAllergen, label: Text("Allergen")) {
                    ForEach(0..<self.vm.listAllergen.count, id:\.self) { id in
                        Text("\(self.vm.listAllergen[id].name)").tag(id)
                    }
                }/*.onChange(of: selectedAllergen) { tag in
                    print("coucou \(tag)")
                }*/
            }
            Section(header: Text("Boutons")) {
                Button(action: validate) {
                    Text("Créer ingrédient")
                }
            }
        }
        .task {
            
            // self.listAllergen = await AllergenService.getAllallergen()
            await self.intent.intentToLoad()
            
        }
        .navigationTitle("Ajouter ingrédient")
    }
    
    func validate() {
        
        let allergen = self.vm.listAllergen[selectedAllergen]
        print(allergen.name)
       let ig = Ingredient(name: self.vm.name, unit: self.vm.unit, availableQuantity:self.vm.availableQuantity, unitPrice: self.vm.unitPrice, associatedAllergen: [allergen], denreeUsed: [], id: nil)
        presentationMode.wrappedValue.dismiss()
        print(ig.associatedAllergen)
        Task{
            let ig = await IngredientService.saveIngredient(ig)
            if ig != nil {
                print("Nouvelle Ingredient  : \(ig?.id)")
            }
         }
       
    }
}
/*
 struct createIngredient_Previews: PreviewProvider {
 static var previews: some View {
 createIngredient()
 }
 }*/
