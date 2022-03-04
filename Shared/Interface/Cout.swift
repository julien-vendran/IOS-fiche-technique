//
//  Cout.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 04/03/2022.
//

import SwiftUI

struct Cout: View {
    
    @State var cout : Cost?
    
    
    var body: some View {
        VStack{
            if let cost = cout{
                Text("Cout des charges : \(cost.coutDesCharges)€")
                Text("Cout des matières : \(cost.coutDesMatiere)€")
                Text("Cout de production : \(cost.coutDeProduction)€")
            }
        }
    }
}

struct Cout_Previews: PreviewProvider {
    static var previews: some View {
        Cout()
    }
}
