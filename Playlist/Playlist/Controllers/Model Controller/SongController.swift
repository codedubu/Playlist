//
//  SongController.swift
//  Playlist
//
//  Created by River McCaine on 1/11/21.
//

import Foundation

class SongController {
    
    // Shared Instance
    static let shared = SongController()
    
    // Source of Truth (S.O.T)
    var songs: [Song] = []
    
    // CRUD Methods
    // Create
    func createSong(newSongtitle: String, newSongArtist: String) {
        // create a song
        let newSong = Song(title: newSongtitle, artist: newSongArtist)
        // add it to the songs array
        songs.append(newSong)
        // TODO: save
        saveToPersistenceStore()
        
    }
    
    // TODO: Update
    
    // Delete
    func deleteSong(songToDelete: Song) {
        //Find the index
        guard let index = songs.firstIndex(of: songToDelete) else { return }
        // remove a song from [songs]
        songs.remove(at: index)
        // TODO: save
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    
    // fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    
    // save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
        
    }
    
    // load
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let foundSongs = try JSONDecoder().decode([Song].self, from: data)
            songs = foundSongs
        } catch {
            print(error)
            print(error.localizedDescription)
        }
        
        
        
    }
    
} // End of class
