//
//  ReadDenree.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct ReadDenree: View {
   @State var denrees : [Denree]
    private var cols = [GridItem](repeating:.init(.flexible()),count:3)
    init(denrees: [Denree]){
        self.denrees = denrees
    }
        var body: some View {
        VStack{
            ForEach((0..<denrees.count), id: \.self) { i in
                LazyVGrid(columns : cols){
                if let ingredient : Ingredient = denrees[i].ingredient{
                        Text("\(ingredient.name)")
                        Text("\(ingredient.unit)")
                    let formatted = String(format: "%.2f", denrees[i].quantity)
                        Text("\(formatted)")
                    }else{
                        Text("Erreur chargement denrée")
                    }
                    
                }
            }
            
        }
        
    }
}

