//
//  Model.swift
//  URLSession_Demo
//
//  Created by Sahil Satralkar on 26/04/22.
//

import Foundation

struct Response : Codable {
    var result : [Model]
}

struct Model : Codable, Identifiable {
    var id : Int
    var name : String
    var email : String
    var gender : String
    var status : String
    
}
