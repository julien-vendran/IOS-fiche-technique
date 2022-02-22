//
//  createAllergen.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by etud on 22/02/2022.
//

import SwiftUI

struct createAllergen: View {
    @State var allergen_created: Allergen
    
    init () {
        allergen_created = Allergen(id: nil, name: "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nom: ")
                .font(.headline)
            TextField("", text: self.$allergen_created.name)
                .padding(.all)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))

        }.padding(.horizontal, 15)
    }
}

struct createAllergen_Previews: PreviewProvider {
    static var previews: some View {
        createAllergen()
    }
}
