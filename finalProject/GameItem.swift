//
//  GameItem.swift
//  finalProject
//
//  Created by Lane Durham on 4/20/26.
//

import SwiftUI

struct GameItem: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let listens: Int
    let imageUrl: String
}
