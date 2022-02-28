//
//  allergenService.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 24/02/2022.
//

import Foundation

class AllergenService {
    
    static var url_back : String = "https://fiche-technique-cuisine-back.herokuapp.com/allergen/"
    
    public static func getallergen(id : Int) async -> Allergen? {
        var output : Allergen? = nil
        do{
            if let url = URL(string: url_back+"\(id)"){
                let decoded : AllergenDTO = try await URLSession.shared.getJSON(from: url)
                output = decoded.allergen
            }
        }catch let error{
            print(error.localizedDescription)
        }
        return output
    }
    
    public static func getAllallergen() async  -> [Allergen]{
        var output : [Allergen] = []
        do{
            if let url = URL(string: url_back){
                let decoded : [AllergenDTO] = try await URLSession.shared.getJSON(from: url)
                //Pour chaque element dto on converti, compactMap =map mais plus simple
                output = decoded.compactMap{ (dto: AllergenDTO) -> Allergen in
                    return dto.allergen
                }
                
            }
        }catch let error{
            
            print(error.localizedDescription)
        }
        return output
    }
    
    public static func saveallergen(_ ingr: Allergen) async {
        if let url = URL(string: url_back){
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField:"Content-Type")
            let dto = AllergenDTO(id_Allergen: ingr.id, allergen_name: ingr.name)
            request.httpMethod = "POST"
            do{
                
                let encoded = try JSONEncoder().encode(dto)
                let _ = try await URLSession.shared.upload(for: request, from:encoded)
            }catch  let error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    public static func deletallergen(id: Int) async {
        if let url = URL(string: url_back+"\(id)"){
            var request = URLRequest(url: url)
            request.httpMethod="DELETE"
            do{
                let _ = try await URLSession.shared.data(for: request)
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
}

