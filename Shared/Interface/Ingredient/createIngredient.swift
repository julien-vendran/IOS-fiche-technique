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
    @State var associatedAllergen: Set<Allergen> = Set()
    @State var listAllergen : [Allergen] = []
    @State var showAllergen : Bool = false
    var cols = [GridItem(.fixed(120)),GridItem(.flexible())]
    
    // @Binding var showingSheet : Bool
    @Environment(\.presentationMode) var presentationMode
    
    
    
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
                    Group{
                        Button("Choix allergen "){
                            showAllergen.toggle()
                        }
                    }.sheet(isPresented: $showAllergen){
                        List(listAllergen, id: \.self, selection: $associatedAllergen) { aler in
                            Text("\(aler.name)")
                        }.environment(\.editMode, .constant(EditMode.active))
                        
                    }
                    Button("Valider", action: validate)
                }
            }
        }.task {
            do{
                let decoded = try await AllergenService.getAllallergen()
                //Pour chaque element dto on converti, compactMap =map mais plus simple
                let maliste : [Allergen] = decoded.compactMap{ (dto: AllergenDTO) -> Allergen in
                    return dto.allergen
                }
                self.listAllergen = maliste
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func validate(){
        let ig = Ingredient(name: name, unit: unit, availableQuantity: availableQuantity, unitPrice: unitPrice, associatedAllergen: Array(associatedAllergen), denreeUsed: [], id: nil)
        print(ig)
        Task{
            await IngredientService.saveIngredient(ig)
        }
        // showingSheet.toggle()
        presentationMode.wrappedValue.dismiss()
    }
}
/*
 struct createIngredient_Previews: PreviewProvider {
 static var previews: some View {
 createIngredient()
 }
 }*/
