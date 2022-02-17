//
//  urlSessionExtend.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 17/02/2022.
//

import Foundation


extension URLSession {
    func getJSON<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await data(from: url)
        let decoder = JSONDecoder() // création d'un décodeur
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    }
}
