//
//  API_Response.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

struct JSONAPIListResponse<Resource: Decodable>: Decodable{
    let data : [Resource]
    let links : JSONAPILinks?
}

struct JSONAPISingleResponse<Resource: Decodable>:Decodable{
    let data: Resource
}

struct JSONAPILinks: Decodable {
    let first: String?
    let last: String?
    let prev: String?
    let next: String?
}
