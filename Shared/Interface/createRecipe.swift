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
    
    @State var name: String = ""
    @State var responsable: String = ""
    @State var nbOfCover: Int = 0
    @State var category: String = ""
    //@State var listOfSteps: [Recipe] = []
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
                    
                    Text("Catégorie")
                    TextField("Catégorie de recette", text: $category)
                }
                //TextField("", text: $recipe_creation.nbOfCover)     // TODO: Accepter que les nombres
            }
            
            Section(header: Text("Liste d'étape")) {
                Text ("Ajout de texte particulier")
            }
            
            Section {
                Button("Valider la création") {
                    let r: Recipe = Recipe(name: self.name, responsable: self.responsable, nbOfCover: self.nbOfCover, category: self.category, listOfStep: [], id: nil)
                    Task {
                        await self.recipeIntent.intentToCreate(recipe: r)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
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
