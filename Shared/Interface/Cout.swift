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
        Form {
            List {
                if let cost = cout {
                    Section(header: Text("Coûts")) {
                        Text("Charges : \(String(format: "%.2f", cost.coutDesCharges))€")
                        Text("Matières : \(String(format: "%.2f", cost.coutDesMatiere))€")
                        Text("Production : \(String(format: "%.2f", cost.coutDeProduction))€")
                    }
                    Section(header: Text("Bénéfices")) {
                        Text("Prix de vente : \(String(format: "%.2f", cost.prixDeVente))€")
                        Text("Bénéfice par portion : \(String(format: "%.2f", cost.beneficeParPortion))€")
                        Text("Seuil de rentabilité : 1 portion")
                    }
                } else {
                    Text("Erreur dans le calcul des coûts")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct Cout_Previews: PreviewProvider {
    static var previews: some View {
        Cout()
    }
}
