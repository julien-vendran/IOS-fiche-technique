//
//  createAllergen.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import SwiftUI

struct createAllergen: View {
    @State var name_allergen: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        Form {
            Section(header: Text("Information générale")) {
                Text("Nom: ")
                TextField("Oeuf", text: self.$name_allergen)
            }
            .navigationTitle("Ajouter un allergène")
            
            Section(header: Text("Boutons")) {
                Button("Ajouter allergène") {
                    Task {
                        let al: Allergen = Allergen(id: nil, name: self.name_allergen)
                        await AllergenService.saveallergen(al)
                        GlobalInformations.allergens.append(al)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Annuler la création") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)
            }
        }
    }
}

struct createAllergen_Previews: PreviewProvider {
    static var previews: some View {
        createAllergen()
    }
}
