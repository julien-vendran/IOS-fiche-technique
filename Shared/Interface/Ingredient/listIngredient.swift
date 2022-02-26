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
    @State var ingredients : [Ingredient]
    @State var showingCreateSheet	: Bool = false
    @State var currentIngredient : Ingredient? = nil
    
    init() {
        self.ingredients=[]
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
                        Group {
                            Button("\(self.vm[index].name)") {
                                self.currentIngredient = self.vm[index]
                            }
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
                    
                }.sheet(item: $currentIngredient) { ing in
                    ReadIngredient(ingredient: ing)
                }.sheet(isPresented: $showingCreateSheet){
                    createIngredient()
                }
                //    EditButton()
                
                
            }
            
            .task {
                if(self.vm.isEmpty){
                    await self.intent.intentToLoad()
                }
          //     self.ingredients = await IngredientService.getAllIngredient()
                    
               
            } .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingCreateSheet.toggle()
                       
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
    }
}

struct listIngredient_Previews: PreviewProvider {
    static var previews: some View {
        listIngredient()
    }
}
