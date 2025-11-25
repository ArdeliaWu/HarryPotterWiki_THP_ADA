//
//  CharacterModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

struct Character: Codable, Identifiable, Hashable{
    let id: String
    let type: String
    let attributes: CharacterAttributes
    
    struct CharacterAttributes: Codable, Hashable {
        let slug: String?
        let name: String?
        let born: String?
        let died: String?
        let gender: String?
        let species: String?
        let height: String?
        let weight: String?
        let hairColor: String?
        let eyeColor: String?
        let skinColor: String?
        let bloodStatus: String?
        let maritalStatus: String?
        let nationality: String?
        let animagus: String?
        let boggart: String?
        let house: String?
        let patronus: String?
        let alias: [String]?
        let familyMembers: [String]?
        let jobs: [String]?
        let romances: [String]?
        let titles: [String]?
        let wands: [String]?
        let image: String?
        let wiki: String?
        
        enum CodingKeys: String, CodingKey {
            case slug, name, born, died, gender, species, height, weight
            case hairColor = "hair_color"
            case eyeColor = "eye_color"
            case skinColor = "skin_color"
            case bloodStatus = "blood_status"
            case maritalStatus = "marital_status"
            case nationality, animagus, boggart, house, patronus, alias
            case familyMembers = "family_members"
            case jobs, romances, titles, wands, image, wiki
        }
    }
}
