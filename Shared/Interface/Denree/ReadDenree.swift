//
//  ReadDenree.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct ReadDenree: View {
    @State var denrees : [Denree]
    var text: String = ""
    init(denrees: [Denree]){
        self.denrees = denrees
        for i: Int in 0..<denrees.count {
            if let ingre: Ingredient = denrees[i].ingredient {
                if (i == denrees.count-1) {
                    text += ingre.name
                } else {
                    text += "\(ingre.name), "
                }
            }
        }
    }
    var body: some View {
        VStack {
            if (text != "") {
                Text(text)
                    .foregroundColor(.purple)
            } else {
                Text("Aucun ingrédient n'est nécessaire")
                    .foregroundColor(.secondary)
            }

        }
        
    }
}

