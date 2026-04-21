//
//  LastFMService.swift
//  finalProject
//
//  Created by Lane Durham on 4/20/26.
//

import SwiftUI

struct LastFMService {
    static let apiKey = "6f07cab3010e929e4862575c68bbb20a"
    
    static func fetchRandomItem(mode: GameMode, randomness: Int, genre: String) async -> GameItem? {
        if mode == .track {
            return await fetchRandomTrack(randomness: randomness, genre: genre)
        } else {
            return await fetchRandomAlbum(randomness: randomness, genre: genre)
        }
    }
    
    private static func fetchRandomTrack(randomness: Int, genre: String) async -> GameItem? {
        let page = Int.random(in: 1...randomness)
        var query = MusicData.All.randomElement() ?? "Drake"
        
        if genre == "Pop" {
            query = MusicData.Pop.randomElement() ?? "Michael-Jackson"
        } else if genre == "Rock" {
            query = MusicData.Rock.randomElement() ?? "The-Beatles"
        } else if genre == "Hip Hop" {
            query = MusicData.HipHop.randomElement() ?? "Kanye-West"
        } else if genre == "Country" {
            query = MusicData.Country.randomElement() ?? "Luke-Combs"
        }
        
        let urlString = "https://ws.audioscrobbler.com/2.0/?method=track.search&track=\(query)&page=\(page)&api_key=\(apiKey)&format=json"
        
        if let url = URL(string: urlString) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(TrackSearchResponse.self, from: data)
                let tracks = decoded.results.trackmatches.track
                
                if tracks.isEmpty {
                    return await fetchRandomTrack(randomness: randomness, genre: genre)
                }
                
                if let random = tracks.randomElement() {
                    let image = await fetchDeezerImage(
                        artist: random.artist,
                        title: random.name
                    )

                    return GameItem(
                        title: random.name,
                        artist: random.artist,
                        listens: Int(random.listeners) ?? 0,
                        imageUrl: image
                    )
                }
                
            } catch {
                print("Track fetch error: ", error)
            }
        }
        
        return nil
    }
    
    private static func fetchRandomAlbum(randomness: Int, genre: String) async -> GameItem? {
        let page = Int.random(in: 1...randomness)
        var query = MusicData.All.randomElement() ?? "Drake"
        
        if genre == "Pop" {
            query = MusicData.Pop.randomElement() ?? "Michael-Jackson"
        } else if genre == "Rock" {
            query = MusicData.Rock.randomElement() ?? "The-Beatles"
        } else if genre == "Hip Hop" {
            query = MusicData.HipHop.randomElement() ?? "Kanye-West"
        } else if genre == "Country" {
            query = MusicData.Country.randomElement() ?? "Luke-Combs"
        }
        
        let urlString = "https://ws.audioscrobbler.com/2.0/?method=album.search&album=\(query)&page=\(page)&api_key=\(apiKey)&format=json"
        
        if let url = URL(string: urlString) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(AlbumSearchResponse.self, from: data)
                let albums = decoded.results.albummatches.album
                
                if albums.isEmpty {
                    return await fetchRandomAlbum(randomness: randomness, genre: genre)
                }
                
                if let random = albums.randomElement() {
                    let image = await fetchDeezerImage(
                        artist: random.artist,
                        title: random.name
                    )

                    return GameItem(
                        title: random.name,
                        artist: random.artist,
                        listens: Int(random.listeners) ?? 0,
                        imageUrl: image
                    )
                }
                
            } catch {
                print("Album fetch error: ", error)
            }
        }
        
        return nil
    }
    
    static func fetchDeezerImage(artist: String, title: String) async -> String {
        let query = "\(artist) \(title)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let urlString = "https://api.deezer.com/search?q=\(query)"
        
        if let url = URL(string: urlString) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decoded = try JSONDecoder().decode(DeezerResponse.self, from: data)
                
                if let first = decoded.data.first {
                    return first.album.cover_big
                }
                
            } catch {
                print("Deezer fetch error:", error)
            }
        }
        
        return ""
    }
}
