//
//  addAllergen.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 28/02/2022.
//



import SwiftUI

struct addAllergen: View {
    @ObservedObject var vm : IngredientCreateVM
    @State var sets : Set<Allergen> = Set()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Allergènes")
                .font(.largeTitle)
         /*   List(selection: $sets) {
                ForEach(0..<vm.listAllergen.count, id: \.self) { index in
                    Group {
                        Text("\(self.vm.listAllergen[index].name)")
                    }
                }
                .onDelete{indexSet in
                    vm.listAllergen.remove(atOffsets: indexSet)
                }
                .onMove{ indexSet, index in
                    vm.listAllergen.move(fromOffsets: indexSet, toOffset: index)
                }
            }*/
           
            /*List(vm.listAllergen, selection: $sets){
                Group{Text("\($0.name)")}
            }*/
            
            Text("\(sets.count)")
            HStack {
                EditButton()
                Button(action: valide) {
                    Text("valider")
                }
                
            }.frame(height: 40)
        }
        /*   .task {
         
         let url = URL(string: "https://fiche-technique-cuisine-back.herokuapp.com/allergen")
         do {
         //Ici on récupere une liste de IngredientDTO (il comprends que le json est un tableau de IngredietnsDTO tout seul) !
         let decoded : [AllergenDTO] = try await URLSession.shared.getJSON(from: url!)
         
         //Pour chaque element dto on converti, compactMap =map mais plus simple
         let maliste : [Allergen] = decoded.compactMap{ (dto: AllergenDTO) -> Allergen in
         return dto.allergen
         }
         self.allergens = maliste
         }  catch let error {
         print(error.localizedDescription)
         }*/
    }
    func valide(){
        print("add -> \(vm.associatedAllergen)")
        print("add -> \(sets)")
        presentationMode.wrappedValue.dismiss()
    }
}

