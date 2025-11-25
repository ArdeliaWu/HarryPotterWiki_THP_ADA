//
//  CharacterModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

import Foundation

struct CharacterResource: Decodable, Identifiable {
    let id: String
    let type: String
    let attributes: CharacterAttributes
}

struct CharacterAttributes: Decodable {
    let slug: String?
    let name: String?
    let born: String?
    let house: String?
    let species: String?
    let patronus: String?
    let image: String?

 
    private enum CodingKeys: String, CodingKey {
        case slug, name, born, house, species, patronus, image
    }
}
