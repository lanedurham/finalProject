//
//  ContentView.swift
//  finalProject
//
//  Created by Lane Durham on 4/20/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedMode: GameMode = .track
    @State private var randomnessLevel: Int = 1 // max 5
    @State private var selectedGenre: String = "All"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    Text("HIGHER")
                        .foregroundStyle(Color(red: 80/255, green: 170/255, blue: 50/255))
                        .font(.system(size: 100))
                        .monospaced()
                        .fontWeight(.bold)
                        //.padding(.top, 120)
                    
                    Text("LOWER")
                        .foregroundStyle(Color(red: 155/255, green: 120/255, blue: 180/255))
                        .font(.system(size: 100))
                        .monospaced()
                        .fontWeight(.bold)
                        .padding(.top, -20)
                    
                    NavigationLink {
                        GameView(
                            mode: selectedMode,
                            randomness: randomnessLevel,
                            genre: selectedGenre
                        )
                    } label: {
                        Image(systemName: "play.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 160)
                            .foregroundStyle(.yellow)
                    }
                    .padding(30)
                    
                    VStack {
                        Text("Genre: \(selectedGenre)")
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                            .font(.title3)
                        
                        Picker("Genre", selection: $selectedGenre) {
                            Text("All").tag("All")
                            Text("Pop").tag("Pop")
                            Text("Rock").tag("Rock")
                            Text("Hip Hop").tag("Hip Hop")
                            Text("Country").tag("Country")
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 60)
                    .padding(.top, 10)
                    
                    VStack {
                        Text("Difficulty: \(randomnessLevel)")
                            .foregroundStyle(.gray)
                            .fontWeight(.bold)
                            .font(.title3)
                        
                        Picker("Randomness", selection: $randomnessLevel) {
                            ForEach(1...5, id: \.self) { level in
                                Text("\(level)").tag(level)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
