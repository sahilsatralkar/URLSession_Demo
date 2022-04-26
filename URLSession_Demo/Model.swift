//
//  Model.swift
//  URLSession_Demo
//
//  Created by Sahil Satralkar on 26/04/22.
//

import Foundation

struct Model : Codable, Identifiable {
    var id : Int
    var name : String
    var email : String
    var gender : String
    var status : String
}
