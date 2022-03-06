//
//  ReadStep.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct ReadStep: View {
    

    private var step: Step
    private var cols = [GridItem](repeating:.init(.flexible()),count:3)
    private let i: Int
  
    init(step: Step, i: Int) {
        self.step = step
        self.i = i + 1
    }
    var body: some View {
        Section(header: Text("Étape \(i): \(step.name) - \(Int(step.duration)) minutes")){
            ReadDenree(denrees: step.denreeUsed)
            Text(self.step.description)
        }
    }
}

/*struct ReadStep_Previews: PreviewProvider {
    static var previews: some View {
        ReadStep(step: Step(name: "", description: "", duration: 0, denreeUsed: [], id: 1))
    }
}*/
