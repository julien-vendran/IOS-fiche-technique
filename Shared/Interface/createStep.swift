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
    //@State var denreeUsed: [Denree] = []
    @ObservedObject var denreeUsed: RecipeDenreeCreateVM = RecipeDenreeCreateVM()
    let col = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var isValid: Bool {
        if (self.name == "") {
            return false
        }
        if (duration <= 0) {
            return false
        }
        return true
    }
    
    init (stepIntent: IntentRecipeCreate) {
        self.stepIntent = stepIntent
        self.stepIntent.addObserver(viewModel: self.denreeUsed)
    }
    
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
            Section(header: EditButton()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .overlay(Text("Liste d'ingrédients"), alignment: .leading)
            ) {
                List {
                    ForEach(self.denreeUsed.denree_list, id:\.id) { d in
                        //TODO: Refaire ça proprement
                        Text("Test ingrédient : \(d.quantity)")
                    }
                    .onDelete() { indexSet in
                        self.denreeUsed.denree_list.remove(atOffsets: indexSet)
                    }
                    .onMove{ indexSet, index in
                        self.denreeUsed.denree_list.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
                
                NavigationLink(destination: CreateDenree(intent: self.stepIntent)) {
                    Button(action: {}) {
                        Text("Lier des ingredients")
                    }
                }
            }
            Section() {
                Button("Ajouter étape") {
                    if (self.description == placeholderString) {
                        self.description = ""
                    }
                    let s: Step = Step(name: self.name, description: self.description, duration: self.duration, denreeUsed: self.denreeUsed.denree_list, id: nil)
                    self.stepIntent.intentToCreate(step: s)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(!self.isValid)
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
