//
//  createIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct createIngredient: View {
    
    @State var name: String = ""
    @State var unit: String = ""
    @State var availableQuantity: Int = 0
    @State var unitPrice: Double = 0
    @State var associatedAllergen: [Allergen] = []
    var cols = [GridItem(.fixed(120)),GridItem(.flexible())]
    
    @Binding var showingSheet : Bool
  
    
    
    var body: some View {
        VStack{
            Form{
                LazyVGrid(columns: cols){
                    Group{
                        Text("Nom :"); TextField("nom ingredient",text: $name)
                    }
                    Group{
                        Text("Unité :"); TextField("unité",text: $unit)
                    }
                    Group{
                        Text("Quantité disponible :"); TextField("",value: $availableQuantity, formatter: NumberFormatter())
                    }
                    Group{
                        Text("Prix unitaire :"); TextField("",value: $unitPrice,formatter: NumberFormatter())
                    }
                }
                Button("Valider", action: validate)
            }
        }
    }
    
    func validate(){
        let ig = Ingredient(name: name, unit: unit, availableQuantity: availableQuantity, unitPrice: unitPrice, associatedAllergen: associatedAllergen, denreeUsed: [], id: nil)
        print(ig)
        Task{
           await IngredientService.saveIngredient(ig)
        }
        showingSheet.toggle()
    }
}
/*
struct createIngredient_Previews: PreviewProvider {
    static var previews: some View {
        createIngredient()
    }
}*/