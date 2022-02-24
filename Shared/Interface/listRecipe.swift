//
//  SwiftUIView.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 15/02/2022.
//
		
import SwiftUI

struct ListRecipe: View {
    @ObservedObject var recipeListVM: RecipeListeVM
    var recipeIntent: IntentRecipeList
    
    @State var showCreationSheet: Bool = false
    @ObservedObject var recipe_creation: Recipe
    
    init () {
        self.recipeIntent = IntentRecipeList()
        self.recipeListVM = RecipeListeVM(recipe: [])
        self.recipe_creation = Recipe(name: "", responsable: "", nbOfCover: 0, category: "", listOfStep: [], id: nil)
        self.recipeIntent.addObserver(viewModel: self.recipeListVM)
    }
    
    var body: some View {
        NavigationView() {
            VStack {
                Spacer()
                List {
                    ForEach((0..<self.recipeListVM.count), id: \.self) { idRecipe in
                        VStack {
                            NavigationLink(destination: ReadRecipe(recipe: self.recipeListVM[idRecipe])) {
                                Text("\(self.recipeListVM[idRecipe].name)")
                            }
                            .navigationTitle("Vos recettes ")
                        }
                    }
                    .onDelete() { indexSet in
                        self.recipeListVM.associated_recipe_list.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("Vos recettes")
            .task {
                if (self.recipeListVM.isEmpty) {
                    await self.recipeIntent.intentToLoad()
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        self.showCreationSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: self.$showCreationSheet) {
                createRecipe(recipeIntent: self.recipeIntent)
            }
        }
    }
}

struct ListRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ListRecipe()
    }
}
	
						
