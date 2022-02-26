//
//  createStep.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 25/02/2022.
//

import SwiftUI

struct CreateStep: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var stepIntent: IntentRecipeCreate
    
    @State var name: String = ""
    @State var description: String = "Entrez la description de votre recette"
    @State var duration: Double = 0.0
    @State var denreeUsed: [Denree] = []
    
    let col = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        let placeholderString: String = "Entrez la description de votre recette"
        Form {
            Section(header: Text("Informations générales")) {
                LazyVGrid(columns: col, alignment: .leading) {
                    Text("Nom :")
                    TextField("Purée", text: $name)
                    
                    Text("Durée (en minutes) :")
                    TextField("", value: self.$duration, format: .number)
                }
                Text("Description :")
                TextEditor(text: self.$description)
                    .foregroundColor(self.description == placeholderString ? .gray : .primary)
                    .onTapGesture {
                        if self.description == placeholderString {
                            self.description = ""
                        }
                    }
            }
            Section(header: Text("Ingrédients nécessaires")) {
                Text("Faire le même bordel pour les ingrédients ^^")
            }
            Section() {
                Button("Ajouter étape") {
                    if (self.description == placeholderString) {
                        self.description = ""
                    }
                    let s: Step = Step(name: self.name, description: self.description, duration: self.duration, denreeUsed: self.denreeUsed, id: nil)
                    self.stepIntent.intentToCreate(step: s)
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Annuler l'ajout de l'étape") {
                    presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.red)
            }
        }
        .navigationTitle("Ajout d'une étape")
    }
}

/*struct createStep_Previews: PreviewProvider {
    static var previews: some View {
        CreateStep()
    }
}*/
