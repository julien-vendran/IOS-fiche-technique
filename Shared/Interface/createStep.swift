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
    @ObservedObject var denreeUsed: RecipeDenreeCreateVM = RecipeDenreeCreateVM()
    let col = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var stepToUpdate: Step?
    @State var updated: Bool = false
    @State var updateMode: Bool = false
    
    var isValid: Bool {
        if (self.name == "") {
            return false
        }
        if (duration <= 0) {
            return false
        }
        return true
    }
    
    init (stepIntent: IntentRecipeCreate, step: Step? = nil) {
        self.stepIntent = stepIntent
        self.stepIntent.addObserver(viewModel: self.denreeUsed)
        self.stepToUpdate = step
        
        if (self.stepToUpdate != nil) {
            self.updateMode = true
            denreeUsed.setUp(denrees: self.stepToUpdate!.denreeUsed)
        }
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
                    ForEach(0..<self.denreeUsed.count, id:\.self) { id in
                        VStack {
                            NavigationLink(destination: CreateDenree(intent: self.stepIntent, denreeToUpdate: self.denreeUsed[id])) {
                                let i: Ingredient = self.denreeUsed[id].ingredient!
                                let qte: String = String(format: "%.2f", self.denreeUsed[id].quantity)
                                Text("\(i.name) (\(qte) \(i.unit))")
                            }
                        }
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
                if (self.stepToUpdate == nil) {
                    Button("Ajouter l'étape") {
                        if (self.description == placeholderString) {
                            self.description = ""
                        }
                        let s: Step = Step(name: self.name, description: self.description, duration: self.duration, denreeUsed: self.denreeUsed.denree_list, id: nil)
                        self.stepIntent.intentToCreate(step: s)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(!self.isValid)
                } else {
                    Button("Modifier l'étape") {
                        if (self.description == placeholderString) {
                            self.description = ""
                        }
                        self.stepToUpdate?.name = self.name
                        self.stepToUpdate?.description = self.description
                        self.stepToUpdate?.duration = self.duration
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(!self.isValid)
                }
                Button("Annuler l'ajout de l'étape") {
                    presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.red)
            }
        }
        .navigationTitle("Ajout d'une étape")
        .onAppear {
            if (self.stepToUpdate != nil && !self.updated) {
                self.updated = true
                self.name = self.stepToUpdate!.name
                self.description = self.stepToUpdate!.description
                self.duration = self.stepToUpdate!.duration
            }
        }
    }
}
