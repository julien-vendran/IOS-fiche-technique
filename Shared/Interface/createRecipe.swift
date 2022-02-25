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
    var recipeInStock: [Recipe]
    
    @State var recipeChoosed: Recipe? = nil
    
    @State var name: String = ""
    @State var responsable: String = ""
    @State var nbOfCover: Int = 0
    @State var category: String = ""
    @State var listOfSteps: [RecipeOrStep] = []
    
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
        self.recipeInStock = recipeInStock
        if (recipeInStock.count > 0) {
            self.recipeChoosed = recipeInStock[0]
        }
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
                //TextField("", text: $recipe_creation.nbOfCover)     // TODO: Accepter que les nombres
            }

            Section(header: EditButton()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .overlay(Text("Liste d'étapes")	, alignment: .leading)
            ) {
                Button("Ajouter une étape") {
                    self.listOfSteps.append(Step(name: "", id: nil))
                }
                /*Picker("", selection: $recipeChoosed) {
                    ForEach(0..<self.recipeInStock.count) { id in
                        Text(self.recipeInStock[id])
                    }
                }*/
                Button("Ajouter une recette") {
                    self.listOfSteps.append(Recipe(name: "", responsable: "", nbOfCover: 0, category: "", listOfStep: [], id: nil))
                }
                List {
                    ForEach(0..<self.listOfSteps.count, id: \.self) { idSOR in
                        if (self.listOfSteps[idSOR] is Step) {
                            Text("Nouvelle étape")
                        }
                        else {
                            Text("Nouvelle Recette")
                        }
                    }
                    .onDelete() { indexSet in
                        self.listOfSteps.remove(atOffsets: indexSet)
                    }
                    .onMove{ indexSet, index in
                        self.listOfSteps.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
            }
            
            Section {
                Button("Valider la création") {
                    let r: Recipe = Recipe(name: self.name, responsable: self.responsable, nbOfCover: self.nbOfCover, category: self.category, listOfStep: [], id: nil)
                    Task {
                        await self.recipeIntent.intentToCreate(recipe: r)
                    }
                    presentationMode.wrappedValue.dismiss()
                }.disabled(!self.isFormValid)
                Button("Annuler la création") {
                    presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.red)
            }
        }
    }
}

/*struct createRecipe_Previews: PreviewProvider {
    static var previews: some View {
        createRecipe()
    }
}*/
