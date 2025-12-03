//
//  PotionModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 01/12/25.
//

import Foundation

struct Potion: Codable, Identifiable, Hashable{
    let id: String
    let type: String
    let attributes: PotionAttributes
    
    struct PotionAttributes: Codable, Hashable {
        let slug: String?
        let characteristics: String?
        let difficulty: String?
        let effect: String?
        let image: String?
        let inventors: String?
        let ingredients: String?
        let manufacturers: String?
        let name: String?
        let sideEffects: String?
        let time: String?
        let wiki: String?
        
        enum CodingKeys: String, CodingKey {
            case slug, name, image, characteristics, effect, ingredients, time, difficulty
            case inventors, manufacturers,wiki
            case sideEffects = "side_effects"
        }
    }
}

