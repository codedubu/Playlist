//
//  SongController.swift
//  Playlist
//
//  Created by River McCaine on 1/11/21.
//

import Foundation

class SongController {
    
    // MARK: - CRUD Methods
    // Create
    static func createSong(newSongtitle: String, newSongArtist: String, playlist: Playlist) {
        // create a song
        let newSong = Song(title: newSongtitle, artist: newSongArtist)
        playlist.songs.append(newSong)
        PlaylistController.shared.saveToPersistenceStore()
    }
    
    // Delete
    static func delete(song: Song, playlist: Playlist) {
        guard let index = playlist.songs.firstIndex(of: song) else { return }
        playlist.songs.remove(at: index)
        PlaylistController.shared.saveToPersistenceStore()
    }
} // End of class
