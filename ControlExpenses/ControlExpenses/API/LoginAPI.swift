//
//  PostAPI.swift
//  ControlExpenses
//
//  Created by COTEMIG on 19/03/18.
//  Copyright © 2018 Cotemig. All rights reserved.
//

import Foundation
import Alamofire

class LoginAPI {
/*
    class func loadLogin(_ user: String, _ password: String, onCompletion: @escaping (User?) -> Void) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        /*
         {
         "usuario": "usuario@email.com",
         "senha": "senha123"
         }
         */
        let parameters: [String:String] = [
            "usuario" : user,
            "senha" : password
        ]
        
        let url = "http://apiteste.fourtime.com/api/usuario/autenticar"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<300)
            .responseJSON { (dataResponse) in
                
                if let data = dataResponse.data, let usuario = try?  JSONDecoder().decode(User.self, from: data) {
                    onCompletion(usuario)
                    return
                }
                
                onCompletion(nil)
        }
    }
*/
    static let baseURL = "https://swapi.co/api"
     
    class func loadLogin(onCompletion: @escaping (Login?) -> Void) {
        let url = baseURL + "/people/3"
     
        Alamofire.request(url).responseJSON { (dataResponse) in
            
            if let data = dataResponse.data, let login = try? JSONDecoder().decode(Login.self, from: data) {
                onCompletion(login)
                return
            }
         
            onCompletion(nil)
        }
    }
}

/*
struct User : Codable {
    var nome : String
    var avatar : String
    var sobrenome : String
}
*/

 struct Login : Codable {
     var name: String
     var height: String
     var mass: String
     var hair_color: String
     var skin_color: String
     var eye_color: String
     var birth_year: String
     var gender: String
     var homeworld: String
     var films: [String]
     var species: [String]
     var vehicles: [String]
     var starships: [String]
     var created: String
     var edited: String
     var url: String
 }
