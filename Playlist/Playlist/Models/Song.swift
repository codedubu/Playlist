//
//  Song.swift
//  Playlist
//
//  Created by River McCaine on 1/11/21.
//

import Foundation


class Song: Codable {
    
    let title: String
    let artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.title == rhs.title && lhs.artist == rhs.artist
    }
}


// lhs                   RHS
// [song 1 .. 10]        song7

///'Are these the same thing?'
// song1.title                 song7.title
// if song1.title == song7.title, returns true.
