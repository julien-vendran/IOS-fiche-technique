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
    @State var allergen : Allergen? = nil
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
        NavigationView{
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
                        
                    }
                    
                }
        
                    NavigationLink(destination: addAllergen(vm: vm)){
             
                        Text("cliquez")
                        
                    }
                
            }
            
            HStack{
                /*   Button("Choix allergen "){
                 showAllergen.toggle()
                 }*/
                Button(action: validate) {
                    Text("valider")
                }
            }
            .task {
                
                // self.listAllergen = await AllergenService.getAllallergen()
                await self.intent.intentToLoad()
                
            }
        }
    }
    
    func validate(){
        
        
        let ig = Ingredient(name: self.vm.name, unit: self.vm.unit, availableQuantity:self.vm.availableQuantity, unitPrice: self.vm.unitPrice, associatedAllergen: Array(self.vm.associatedAllergen), denreeUsed: [], id: nil)
        print(ig.associatedAllergen)
        print(vm.associatedAllergen)
        /* Task{
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
