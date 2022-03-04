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
  
    init(step: Step){
        self.vm = StepReadVM(step: step)
        self.intent = IntentStepRead()
        self.intent.addObserver(viewModel: self.vm)

    }
    var body: some View {
        Section(header: Text(vm.step.name)){
            ReadDenree(denrees: vm.step.denreeUsed)
        }
        .task {
            
        //  await intent.intentToLoad(denrees: vm.step.denreeUsed)
        }
    }
}

struct ReadStep_Previews: PreviewProvider {
    static var previews: some View {
        ReadStep(step: Step(name: "", description: "", duration: 0, denreeUsed: [], id: 1))
    }
}
