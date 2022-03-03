//
//  ReadDenree.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct ReadDenree: View {
    var denrees : [Denree]
    private var cols = [GridItem](repeating:.init(.flexible()),count:3)
    init(denrees: [Denree]){
        self.denrees = denrees
      //  print("Denrées : \(denrees.count)")
    }
    var body: some View {
        VStack{
            List{
                ForEach(denrees, id:\.self.id){ denree in
                    LazyVGrid(columns : cols){
                        if let ingredient : Ingredient = denree.ingredient{
                            Text(" a \(ingredient.name)")
                            Text(" b \(ingredient.unit)")
                            Text(" c \(denree.quantity)")
                        }
                    }
                }
            }
        }
    }
}

struct ReadDenree_Previews: PreviewProvider {
    static var previews: some View {
        ReadDenree(denrees: [])
    }
}
