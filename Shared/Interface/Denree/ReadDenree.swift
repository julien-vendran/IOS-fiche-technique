//
//  ReadDenree.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct ReadDenree: View {
   @Binding var denrees : [Denree]
    private var cols = [GridItem](repeating:.init(.flexible()),count:3)
    init(denrees: Binding<[Denree]>){
        self._denrees = denrees
   
    }
        var body: some View {
        VStack{
            Text("Denrée à print : \(denrees.count)")
            ForEach((0..<denrees.count), id: \.self) { i in
                LazyVGrid(columns : cols){
                
                if let ingredient : Ingredient = denrees[i].ingredient{
                        Text("\(ingredient.name)")
                        Text("\(ingredient.unit)")
                        Text("\(denrees[i].quantity)")
                    }else{
                        Text("Ingredient vide")
                    }
                    
                }
            }
            Text("On recçoit \(denrees.count)")
        }
        
    }
}

