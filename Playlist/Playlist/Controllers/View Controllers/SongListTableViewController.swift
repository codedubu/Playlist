//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by River McCaine on 1/11/21.
//

import UIKit

class SongListTableViewController: UITableViewController {
    
    // outlets, properties, lifecycle methods ,actions, data source, helper functions
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    // MARK: - Properties
    
    // landing pad
    var playlist: Playlist?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text, !songTitle.isEmpty,
              let artistName = artistNameTextField.text, !artistName.isEmpty,
              let playlist = playlist else { return }
        
        SongController.createSong(newSongtitle: songTitle, newSongArtist: artistName, playlist: playlist)
       
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        songTitleTextField.resignFirstResponder()
        artistNameTextField.resignFirstResponder()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.songs.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        guard let song = playlist?.songs[indexPath.row] else { return cell }
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let playlist = playlist else { return }
            let songToDelete = playlist.songs[indexPath.row]
            SongController.delete(song: songToDelete, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
