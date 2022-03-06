//
//  createRecipe.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct createRecipe: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    //On va s'en servir pour communiquer nos intentions 
    var recipeIntent: IntentRecipeList
    var stepIntent: IntentRecipeCreate
    var recipeInStock: [Recipe]
    
    @State var recipeChoosed: Recipe? = nil
    
    @State var name: String = ""
    @State var responsable: String = ""
    @State var nbOfCover: Int = 0
    @State var category: String = ""
    @ObservedObject var listOfSteps: RecipeCreateStepListVM = RecipeCreateStepListVM()
    
    @State private var recipeToAdd: Int  = 0
    
    var isFormValid: Bool {
        if (self.name == "") {
            return false
        }
        if (self.responsable == "") {
            return false
        }
        if (self.nbOfCover <= 0) {
            return false
        }
        if (self.category == "") {
            return false
        }
        return true
    }
    
    init (recipeIntent: IntentRecipeList, recipeInStock: [Recipe]) {
        self.recipeIntent = recipeIntent
        
        //On va se servir de ça pour avoir le retour sur les données des étapes ajoutées
        self.stepIntent = IntentRecipeCreate()
        self.recipeInStock = recipeInStock
        
        self.stepIntent.addObserver(viewModel: self.listOfSteps)
        if (recipeInStock.count > 0) {
            self.recipeChoosed = recipeInStock[0]
        }
        self.listOfSteps.recipeOrStep_list = []
    }
    
    let col = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        Form {
            Section(header: Text("Informations générales")) {
                LazyVGrid(columns: col, alignment: .leading) {
                    Text("Nom")
                    TextField("Nom de la recette", text: $name)
                    
                    Text("Responsable")
                    TextField("Responsable", text: $responsable)
                    
                    Text("Nombre de couvert")
                    Stepper(value: $nbOfCover, in: 0...999) {
                        Text("\(self.nbOfCover)")
                    }
                    
                    Text("Catégorie")
                    TextField("Catégorie de recette", text: $category)
                }
            }

            Section(header: EditButton()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .overlay(Text("Liste d'étapes")	, alignment: .leading)
            ) {
                NavigationLink (destination: CreateStep(stepIntent: self.stepIntent)) {
                    Button(action: {}) {
                        Text("Ajouter une étape")
                    }
                }
                Picker(selection: $recipeToAdd, label: Text("Recette")) {
                    ForEach(0..<self.recipeInStock.count) { idRecipe in
                        Text("\(self.recipeInStock[idRecipe].name)").tag(idRecipe)
                    }
                }.onChange(of: recipeToAdd) { tag in
                    self.listOfSteps.append(self.recipeInStock[self.recipeToAdd])
                }
                List {
                    ForEach(0..<self.listOfSteps.count, id: \.self) { idSOR in
                        if let step: Step = self.listOfSteps[idSOR] as? Step {
                            NavigationLink(destination: CreateStep(stepIntent: self.stepIntent, step: step)) {
                                let s: Step = self.listOfSteps[idSOR] as! Step
                                
                                let formatted = String(format: "%.2f",s.duration)
                                Text("\(s.name): \(formatted) minutes")
                            }
                        } else {
                            Text("[Recette] \(self.listOfSteps[idSOR].name)")
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete() { indexSet in
                        self.listOfSteps.recipeOrStep_list.remove(atOffsets: indexSet)
                    }
                    .onMove{ indexSet, index in
                        self.listOfSteps.recipeOrStep_list.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
            }
            
            Section {
                Button("Valider la création") {
                    let r: Recipe = Recipe(name: self.name, responsable: self.responsable, nbOfCover: self.nbOfCover, category: self.category, listOfStep: self.listOfSteps.recipeOrStep_list, id: nil)
                    Task {
                        await self.recipeIntent.intentToCreate(recipe: r)
                    }
                    presentationMode.wrappedValue.dismiss()
                }.disabled(!self.isFormValid)
                Button("Annuler la création") {
                    self.stepIntent.intentToCancel()
                    presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.red)
            }
        }
        .navigationTitle("Création d'une recette")
        .navigationBarBackButtonHidden(true)
    }
}
