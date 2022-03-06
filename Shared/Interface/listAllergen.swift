//
//  listIngredient.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

struct listAllergen: View {
    @State var allergens : [Allergen]
    init() {
        self.allergens = GlobalInformations.allergens
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<allergens.count, id: \.self) { index in
                    Group {
                        Text("\(self.allergens[index].name)")
                    }
                }
            }
            .navigationTitle("Allergènes")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: createAllergen()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
