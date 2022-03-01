//
//  addAllergen.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 28/02/2022.
//



import SwiftUI

struct addAllergen: View {
    @ObservedObject var vm : IngredientCreateVM
    // @State var sets : Set<Allergen> = Set()
    @Environment(\.presentationMode) var presentationMode
    @State var allergen : Allergen? = nil
    var body: some View {
        VStack{
            Picker("Please choose a allergen", selection: $allergen) {
                ForEach(0..<self.vm.listAllergen.count, id:\.self) { id in
                    Text("\(self.vm.listAllergen[id].name)").tag(id)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding(1)
            if allergen != nil {
                Text("You selected: \(allergen!.name)")
            }
            
        }
    }
    func valide(){
        if allergen != nil {
            vm.associatedAllergen.insert(allergen!)
        }
        presentationMode.wrappedValue.dismiss()
    }
}

