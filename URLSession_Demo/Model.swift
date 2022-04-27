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
    
    func fetch() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gorest.co.in"
        components.path = "/public/v2/users"
        
        
        guard let url = components.url else {
            preconditionFailure("Failed to construct URL")
        }
        
//        let task = URLSession.shared.dataTask(with: url) {
//            data, response, error in
//
//            DispatchQueue.main.async {
//                if let data = data {
//                    let model = [Model]
//
//                }
//            }
//        }
    }
}
