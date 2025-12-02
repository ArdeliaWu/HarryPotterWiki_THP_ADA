//
//  API.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 25/11/25.
//

import Foundation

enum PotterEndpoint {
    case books (page: Int? = nil, size: Int? = nil)
    case book(bookId: String)
    case chapters(bookId: String)
    case movies (page: Int? = nil, size: Int? = nil)
    case movie(movieId:String)
    case characters(page: Int? = nil, size: Int? = nil, filterNameContains: String? = nil, sort: String? = nil)
    case character(characterId : String)
    case potions (page: Int? = nil, size: Int? = nil)
    case potion(potionId: String)
    case spells (page: Int? = nil, size: Int? = nil)
    case spell(spellId: String)
    
    private static var baseURL : URL {
        guard let url = URL(string: "https://api.potterdb.com/v1") else {
            fatalError("Invalid base URL string for PotterDb API")
        }
        return url
    }
    
    var url: URL{
        switch self {
    
        case .characters(let page, let size, let filter, let sort):
            let components = URLComponents(url: PotterEndpoint.baseURL.appending(path: "characters"), resolvingAgainstBaseURL: false)
            guard var comps = components else {
                fatalError("Failed to build URLComponents for characters endpoint")
            }
            
            var items: [URLQueryItem] = []
            
            //When fetching too much content data will automatically paginate
            if let page = page {
                items.append(URLQueryItem(name: "page[number]", value: String(page)))
            }
            
            if let size = size {
                items.append(URLQueryItem(name: "page[size]", value: String(size)))
            }
            
            //Filtering Character
            if let filter = filter, !filter.isEmpty{
                items.append(URLQueryItem(name: "filter[name_cont]", value: filter))
            }
            
            if let sort = sort, !sort.isEmpty{
                items.append(URLQueryItem(name: "sort", value: sort))
            }
            
            if !items.isEmpty{
                comps.queryItems = items
            }
            
            guard let finalURL = comps.url else {
                fatalError("Failed to get URL from URLComponents for characters endpoint with query items \(items)")
            }
            return finalURL
            
            
        case .books (let page, let size,):
            let components = URLComponents(url: PotterEndpoint.baseURL.appending(path: "books"), resolvingAgainstBaseURL: false)
            guard var comps = components else {
                fatalError("Failed to build URLComponents for characters endpoint")
            }
            
            var items: [URLQueryItem] = []
            
            //When fetching too much content data will automatically paginate
            if let page = page {
                items.append(URLQueryItem(name: "page[number]", value: String(page)))
            }
            
            if let size = size {
                items.append(URLQueryItem(name: "page[size]", value: String(size)))
            }
            
        case .book(let bookId):
            return PotterEndpoint.baseURL.appending(path: "books/\(bookId)")
            
        case .chapters(let bookId):
            return PotterEndpoint.baseURL.appending(path: "books/\(bookId)/chapters")
        
        case .movies:
            return PotterEndpoint.baseURL.appending(path: "movies")
            
        case .movie(let movieId):
            return PotterEndpoint.baseURL.appending(path: "movies/\(movieId)")
            
        case .character(let characterId):
            return PotterEndpoint.baseURL.appending(path: "characters/\(characterId)")
        
        case .potions:
            return PotterEndpoint.baseURL.appending(path: "potions")
            
        case .potion(let potionId):
            return PotterEndpoint.baseURL.appending(path: "potions/\(potionId)")
            
        case .spells:
            return PotterEndpoint.baseURL.appending(path: "spells")
        
        case .spell(let spellId):
            return PotterEndpoint.baseURL.appending(path:"spells/\(spellId)")
            
            
        }
    }
}
