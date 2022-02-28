//
//  createIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct createIngredient: View {
    @ObservedObject var vm : IngredientCreateVM
    var intent : IntentIngredientCreate
    @State var showAllergen : Bool = false
    var cols = [GridItem(.fixed(120)),GridItem(.flexible())]
    @State private var selection = Set<Allergen>()
    
    // @Binding var showingSheet : Bool
    @Environment(\.presentationMode) var presentationMode
    
    init(){
        self.vm = IngredientCreateVM()
        self.intent = IntentIngredientCreate()
        self.intent.addObserver(viewModel: self.vm)
    }
    
    
    var body: some View {
        VStack{
            Form{
                LazyVGrid(columns: cols){
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
                    Group{
                        Button("Choix allergen "){
                            showAllergen.toggle()
                        }
                        
                    }.sheet(isPresented: $showAllergen){
                     /*   List(selection: $vm.associatedAllergen) {
                            ForEach(0..<vm.listAllergen.count, id: \.self) { index in
                                Text("\(vm.listAllergen[index].name)")
                            }
                         EditButton()
                        }
                      */
                        VStack {
                            List(vm.listAllergen, id: \.id, selection: $selection) { allergen in
                                Text("\(allergen.name)")
                            }
                            EditButton()
                        }
                    }
                    
                }
            }
        }.task {
            
           // self.listAllergen = await AllergenService.getAllallergen()
           await self.intent.intentToLoad()
            
        }
    }
    
    func validate(){/*
        let ig = Ingredient(name: name, unit: unit, availableQuantity: availableQuantity, unitPrice: unitPrice, associatedAllergen: Array(associatedAllergen), denreeUsed: [], id: nil)
        print(ig)
        Task{
            //     await IngredientService.saveIngredient(ig)
        }
        print(associatedAllergen)
        print("on valide")
        // showingSheet.toggle()
        presentationMode.wrappedValue.dismiss()*/
    }
}
/*
 struct createIngredient_Previews: PreviewProvider {
 static var previews: some View {
 createIngredient()
 }
 }*/
