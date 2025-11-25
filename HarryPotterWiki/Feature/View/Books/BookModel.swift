//
//  BookModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

struct Book: Codable, Identifiable, Hashable {
    let id: String
    let type: String
    let attributes: BookAttributes
    
    struct BookAttributes: Codable, Hashable {
        let slug: String?
        let author: String?
        let cover: String?          
        let dedication: String?
        let pages: Int?
        let releaseDate: String?
        let summary: String?
        let title: String?
        let wiki: String?
        
        enum CodingKeys: String, CodingKey {
            case slug, author, cover, dedication, pages, summary, title, wiki
            case releaseDate = "release_date"
        }
    }
}
