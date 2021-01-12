//
//  PlaylistController.swift
//  Playlist
//
//  Created by River McCaine on 1/12/21.
//

import Foundation

class PlaylistController {
    
    // MARK: - Shared Instance
    static let shared = PlaylistController()
    
    // MARK: - Source of Truth
    var playlists: [Playlist] = []
    
    // MARK: - CRUD
    //Create
    func createPlaylistWith(newTitle: String) {
        let newPlaylist = Playlist(title: newTitle)
        playlists.append(newPlaylist)
        saveToPersistenceStore()
    }
    
    //Delete
    func deletePlaylist(playlistToDelete: Playlist) {
        guard let index = playlists.firstIndex(of: playlistToDelete) else { return }
        playlists.remove(at: index)
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
            let data = try JSONEncoder().encode(playlists)
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
            let foundPlaylists = try JSONDecoder().decode([Playlist].self, from: data)
            playlists = foundPlaylists
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
} // End of class
