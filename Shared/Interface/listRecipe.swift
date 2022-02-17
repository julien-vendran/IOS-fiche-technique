//
//  SwiftUIView.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//
		
import SwiftUI

struct ListRecipe: View {
    @State var recipeList: [Recipe] = [
        Recipe( name: "Tomate farcie",
                responsable: "Cuisinier",
                nbOfCover: 3,
                category: "Plat",
                listOfStep: [])
    ]
    
    var body: some View {
        VStack {
            Spacer()
            /*
            Text("Liste de vos recettes ")
                .font(.largeTitle)
             */
            List {
                ForEach(recipeList, id: \.id) { recipe in
                    VStack {
                        Text("\(recipe.name)")
                    }
                }
                .onDelete() { indexSet in
                    recipeList.remove(atOffsets: indexSet)
                }
            }
            EditButton()
        }
        .navigationTitle("Vos recettes")
    }
}

struct ListRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ListRecipe()
    }
}
	
						
