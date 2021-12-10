//
//  UserModel.swift
//  MapppppPPPp
//
//  Created by Преподаватель on 10.12.2021.
//

import Foundation

struct UserModel: Decodable{
    let id: Int
    let name: String
    let username: String
    let email: String
    var address: address
    
    struct address: Decodable{
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        var geo: geo
        
        struct geo: Decodable{
            var lat: String
            var lng: String
        }
    }
    
    let phone: String
    let website: String
    let company: company
    
    struct company: Decodable{
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
