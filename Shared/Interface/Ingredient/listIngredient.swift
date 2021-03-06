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
                        NavigationLink(destination: ReadIngredient(ingredient: self.vm[index] , parent_intent: self.intent)) {
                            if (self.vm[index].availableQuantity > 0) {
                                Text("\(self.vm[index].name)")
                            } else if (self.vm[index].availableQuantity == 0) {
                                Text("\(self.vm[index].name) - \(self.vm[index].availableQuantity) restant")
                                    .foregroundColor(.yellow)
                            } else {
                                Text("\(self.vm[index].name) - \(-1 * self.vm[index].availableQuantity) manquants")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete{ indexSet in
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
                .refreshable {
                    print("refresh")
                    GlobalInformations.ingredients = await IngredientService.getAllIngredient()
                    self.intent.intentToLoad()
                }
            
            }
            .navigationTitle("Liste d'ingr??dients")
            .onAppear() {
                self.intent.intentToLoad()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: CreateIngredient(parent_intent: self.intent)) {
                        Image(systemName: "plus")
                    }
                    
                }
            }
        }
        .navigationTitle("Liste d'ingr??dients")
    }
}

struct listIngredient_Previews: PreviewProvider {
    static var previews: some View {
        listIngredient()
    }
}
