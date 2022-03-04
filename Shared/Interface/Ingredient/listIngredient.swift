//
//  listIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

struct listIngredient: View {
    @ObservedObject var vm: IngredientListVM
    var intent: IntentIngredientList
    
    init() {
 
        vm = IngredientListVM(ingredient: [])
        intent = IntentIngredientList()
        intent.addObserver(viewModel: vm)
    }
    var body: some View {
        NavigationView() {
            VStack {
                Spacer()
                List {
                    ForEach(0..<vm.count, id: \.self) { index in
                        NavigationLink(destination: ReadIngredient(ingredient: self.vm[index])) {
                            Text("\(self.vm[index].name)")
                        }
                    }
                    .onDelete{indexSet in
                        let toRemove = vm.remove(atOffsets: indexSet)
                        Task{
                            for ingre in toRemove{
                               await intent.intentToDelete(ingredient: ingre)
                            }
                        }
                    
                    }
                    .onMove{ indexSet, index in
                        vm.move(fromOffsets: indexSet, toOffset: index)
                    }
                    
                }
            
            }
            .navigationTitle("Liste d'ingrédients")
            .task {
                if(self.vm.isEmpty) {
                    await self.intent.intentToLoad()
                }
          //     self.ingredients = await IngredientService.getAllIngredient()
                    
               
            } .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: CreateIngredient()) {
                        Image(systemName: "plus")
                    }
                    
                }
            }
        }
        .navigationTitle("Liste d'ingrédients")
    }
}

struct listIngredient_Previews: PreviewProvider {
    static var previews: some View {
        listIngredient()
    }
}
