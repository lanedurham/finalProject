//
//  APIModels.swift
//  finalProject
//
//  Created by Lane Durham on 4/20/26.
//

import SwiftUI

struct TrackSearchResponse: Codable {
    let results: TrackResults
}

struct TrackResults: Codable {
    let trackmatches: TrackMatches
}

struct TrackMatches: Codable {
    let track: [TrackApi]
}

struct TrackApi: Codable {
    let name: String
    let artist: String
    let listeners: String
    let image: [ImageApi]
}

struct AlbumSearchResponse: Codable {
    let results: AlbumResults
}

struct AlbumResults: Codable {
    let albummatches: AlbumMatches
}

struct AlbumMatches: Codable {
    let album: [AlbumApi]
}

struct AlbumApi: Codable {
    let name: String
    let artist: String
    let listeners: String
    let image: [ImageApi]
}

struct DeezerResponse: Codable {
    let data: [DeezerTrack]
}

struct DeezerTrack: Codable {
    let album: DeezerAlbum
}

struct DeezerAlbum: Codable {
    let cover_big: String
}

struct ImageApi: Codable {
    let text: String
    enum CodingKeys: String, CodingKey {
        case text = "#text"
    }
}
