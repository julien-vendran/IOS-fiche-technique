//
//  IntentStepRead.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 02/03/2022.
//

import Foundation
import Combine

enum IntentStateStepRead: CustomStringConvertible {
    case ready
    case loading
    case load
    case loaded([Denree])
    
    
    var description: String {
        switch self {
        case .ready:
            return "state : .ready"
        case .loading:
            return "state : .loading"
        case .load:
            return "state : .load"
        case .loaded(_):
            return "state : .loaded(Data)"
            
        }
    }
}

class IntentStepRead {
    private var state = PassthroughSubject<IntentStateStepRead, Never>()
    
    func addObserver (viewModel: StepReadVM) {
        self.state.subscribe(viewModel)
    }
    
    func intentToLoad(denrees: [Denree]) async {
        self.state.send(.loading)
     /*   var denree_to_load : [Denree] = await withTaskGroup(of:Denree.self) { group in
            var d = [Denree]()
            d.reserveCapacity(denrees.count)
            // adding tasks to the group and fetching movies
            for denree in denrees {
                group.addTask{
                   
                        return  await DenreeService.getDenree(id: denree.id!)!
                   
                   
                }
            }
            // grab movies as their tasks mplete, and append them to the `movies` array
            for await denree in group {
                d.append(denree)
            }
            
            return d
        }*/
        var denree_to_load : [Denree] = []
      /*  for denree in denrees {
             denree_to_load.append(await DenreeService.getDenree(id: denree.id!)!)
        }*/
        denree_to_load.append(await DenreeService.getDenree(id: 32)!)
        
        print(" qte \(denree_to_load.count)")
        self.state.send(.loaded(denree_to_load))
        self.state.send(.ready)
    }
    
    
    
    
    
}
