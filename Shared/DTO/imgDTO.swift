//
//  imgDTO.swift
//  fiche-technique-cuisine (iOS)
//
//  Created by m1 on 19/02/2022.
//

import Foundation

struct imgDTO :Codable {
    
    var results : [ContentDTO]
    
}
        
struct ContentDTO : Codable{
    var urls : UrlDTO?
}

struct UrlDTO : Codable{
    var raw : String
    var full : String
    var regular : String
    var small : String
    var thumb : String
}
