//
//  MovieModel.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/18/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieModel: Mappable {
    
    var id: Int?
    var name: String?
    var title: String?
    var overview: String?
    var poster_path: String?
    var vote_average: Float?
    
    required init?(map: Map) {
        
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        title <- map["title"]
        overview <- map["overview"]
        poster_path <- map["poster_path"]
        vote_average <- map["vote_average"]
    }
    
}
