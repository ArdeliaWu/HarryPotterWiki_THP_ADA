//
//  SpellModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 01/12/25.
//

import Foundation
struct Spell: Codable, Identifiable, Hashable{
    let id: String
    let type: String
    let attributes: SpellAttributes
    
    struct SpellAttributes: Codable, Hashable {
        let slug: String?
        let category: String?
        let creater: String?
        let effect: String?
        let hand: String?
        let image: String?
        let incantation: String?
        let light: String?
        let name: String?
        let wiki: String?
    }
}
