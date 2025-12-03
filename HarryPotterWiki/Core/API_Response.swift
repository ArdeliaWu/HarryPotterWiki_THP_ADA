//
//  API_Response.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation


struct APIResponse<T: Codable>: Codable {
    let data: [T]?
    let links: Links?
    let meta: Meta?
}


struct SingleAPIResponse<T: Codable>: Codable {
    let data: T?
}

struct Links: Codable {
    let first: String?
    let last: String?
    let prev: String?
    let next: String?
    let selfLink: String?
    
    enum CodingKeys: String, CodingKey {
        case first, last, prev, next
        case selfLink = "self"
    }
}

struct Meta: Codable {
    let pagination: Pagination?
    let generatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case pagination
        case generatedAt = "generated_at"//Timestamp when the response was generated
    }
}

struct Pagination: Codable {
    let current: Int?
    let records: Int?
    let last: Int?
}
