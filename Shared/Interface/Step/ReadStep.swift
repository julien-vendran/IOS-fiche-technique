//
//  ReadStep.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 02/03/2022.
//

import SwiftUI

struct ReadStep: View {
    
    @ObservedObject var vm : StepReadVM
    private var intent: IntentStepRead
    private var cols = [GridItem](repeating:.init(.flexible()),count:3)
    private let i: Int
  
    init(step: Step, i: Int) {
        self.vm = StepReadVM(step: step)
        self.intent = IntentStepRead()
        self.i = i + 1
        self.intent.addObserver(viewModel: self.vm)
    }
    var body: some View {
        Section(header: Text("Étape \(i): \(vm.step.name) - \(Int(vm.step.duration)) minutes")){
            ReadDenree(denrees: vm.step.denreeUsed)
            Text(self.vm.step.description)
        }
    }
}

/*struct ReadStep_Previews: PreviewProvider {
    static var previews: some View {
        ReadStep(step: Step(name: "", description: "", duration: 0, denreeUsed: [], id: 1))
    }
}*/
