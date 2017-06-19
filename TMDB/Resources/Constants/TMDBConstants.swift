//
//  APIConstants.swift
//  TMDB
//
//  Created by Roman Osadchuk on 6/17/17.
//  Copyright © 2017 RomanOsadchuk. All rights reserved.
//

import Foundation

struct TMDBConstants {
    
    static let SchemeHTTPS = "https"

    struct API {
        static let Host = "api.themoviedb.org"
        static let Version = "3"
        static let KeyName = "api_key"
        static let KeyValue = "e053a48674816eb5d9afd436ef9585a0"
    }
    
    struct Image {
        static let Host = "image.tmdb.org"
        static let Path = "t/p"
        static let DefaultSize = "w500"
    }
    
    struct Search {
        static let Path = "search"
        static let Query = "query"
    }

    enum Genre: String {
        case Movie = "movie"
        case TV = "tv"
    }
    
    enum BlockFilter: String {
        case OnTheAir = "on_the_air"
        case NowPlaying = "now_playing"
        case Popular = "popular"
        case TopRated = "top_rated"
    }
}
