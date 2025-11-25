//
//  ChapterModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

struct Chapter: Codable, Identifiable, Hashable {
    let id: String
    let type: String
    let attributes: ChapterAttributes
    
    struct ChapterAttributes: Codable, Hashable {
        let slug: String?
        let order: Int?
        let summary: String?
        let title: String?
    }
}
