//
//  MoviesModel.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 01/12/25.
//

import Foundation


struct Movie: Codable, Identifiable, Hashable{
    let id: String
    let type: String
    let attributes: MovieAttributes
    
    struct MovieAttributes: Codable, Hashable {
        let slug: String?
        let boxOffice: String?
        let budget: String?
        let cinematographers: [String]?
        let directors: [String]?
        let distributors: [String]?
        let editors: [String]?
        let musicComposers: [String]?
        let poster: String?
        let producers: [String]?
        let rating: String?
        let releaseDate: String?
        let runningTime: String?
        let screenwriters: [String]?
        let summary: String?
        let title: String?
        let trailer: String?
        let wiki: String?
        
        enum CodingKeys: String, CodingKey {
            case slug, poster, producers, rating, screenwriters, summary, title,trailer,wiki
            case budget, cinematographers, directors, distributors, editors
            case boxOffice = "box_office"
            case musicComposers = "music_composers"
            case releaseDate = "release_date"
            case runningTime = "running_time"
        }
    }
}

