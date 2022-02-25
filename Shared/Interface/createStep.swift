//
//  createStep.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 25/02/2022.
//

import SwiftUI

struct CreateStep: View {
    var stepIntent: IntentRecipeCreate
    
    @State var name: String = ""
    @State var description: String = ""
    @State var duration: Double = 0.0
    @State var denreeUsed: [Denree] = []
    
    let col = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button("Ajouter une étape test") {
                print("On vient d'appuyer sur le bouton")
                //self.stepIntent.intentToCreate(step: Step(name: "Test d'étape", id: nil))
            }
        }.navigationTitle("Création d'une recette")
    }
}

/*struct createStep_Previews: PreviewProvider {
    static var previews: some View {
        CreateStep()
    }
}*/
