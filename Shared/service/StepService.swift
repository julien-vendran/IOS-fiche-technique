//
//  StepService.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 26/02/2022.
//

import Foundation

class StepService {
    
    private static var url_back =  "https://fiche-technique-cuisine-back.herokuapp.com/step"
    private static var url = URL(string: url_back)
    
    public static func getStep(id : Int) async  -> Step? {
        var output : Step? = nil
        do{
            if let url = URL(string: url_back+"\(id)"){
                let decoded : StepDTO = try await URLSession.shared.getJSON(from: url)
                output = decoded.step
            }
        } catch let error{
            print(error.localizedDescription)
        }
        return output
    }
    public static func getAllStep() async  -> [Step]{
        var output : [Step] = []
        do{
            if let url = URL(string: url_back){
                let decoded : [StepDTO] = try await URLSession.shared.getJSON(from: url)
                output = decoded.compactMap{ (dto: StepDTO) -> Step in
                    return dto.step
                }
            }
        } catch let error{
            
            print(error.localizedDescription)
        }
        return output
    }
    
    static func createStepDTO(_ step: Step) -> StepDTO {
        
        let list_denree: [DenreeDTO] = step.denreeUsed.compactMap {
            (d: Denree) -> DenreeDTO in
            return DenreeService.createDenreeDTO(d)
        }
        
        let step_dto: StepDTO = StepDTO(id: step.id, name: step.name, description: step.description, duration: step.duration, denreeUsed: list_denree)
        return step_dto
    }
    
    /**
     Enregistre les denrées en base de données, met à jour le tableau de denrées et de nos steps puis va retourner notre step mise à jour
     */
    static func saveDenreeFromStep(_ step: Step) async -> Step {
        let s: Step = step
        for i: Int in 0..<step.denreeUsed.count { //Pour chaque denrée
            //On l'enregistre en BD
            let denree_tmp: Denree? = await DenreeService.createDenree(step.denreeUsed[i])
            
            if (denree_tmp != nil) { //Si l'enregistrement s'est bien passé
                s.denreeUsed[i] = denree_tmp!
                s.denreeUsed[i].id = denree_tmp!.id //On met à jour l'id de notre denrée pour notre step
            } else {
                //Gérer l'erreur d'ajout d'une denrée
            }
        }
        return s //On retourne notre nouvelle étape tout propre
    }
    
    static func createStep(step: Step) async -> Step? {
        if let url_back = self.url {
            var request = URLRequest(url: url_back)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            //D'abord, on enregistre nos denrées en BD
            let new_Step: Step = await StepService.saveDenreeFromStep(step)
            let step_dto: StepDTO = StepService.createStepDTO(new_Step)
            
            do {
                let encoded = try JSONEncoder().encode(step_dto)
                let addedValue = try await URLSession.shared.upload(for: request, from: encoded)
                let addedStep: StepDTO? = JSONHelpler.decode(data: addedValue.0)
                if (addedStep != nil) {
                    let step_created = addedStep!.step
                    step_created.denreeUsed = new_Step.denreeUsed
                    return step_created
                } else {
                    return nil
                }
                
            } catch let error {
                print(error)
            }
        }
        return nil
    }
}
