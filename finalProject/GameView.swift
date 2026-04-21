//
//  GameView.swift
//  finalProject
//
//  Created by Lane Durham on 4/20/26.
//

import SwiftUI

struct GameView: View {
    @State private var topItem: GameItem?
    @State private var bottomItem: GameItem?
    @State private var score = 0
    @State private var gameOver = false
    @State private var hasGuessed = false
    @State private var bottomImageLoaded = false
    @State private var initialLoad = true

    let mode: GameMode
    let randomness: Int
    let genre: String
    
    init(
        mode: GameMode,
        randomness: Int,
        genre: String,
        topItem: GameItem? = nil,
        bottomItem: GameItem? = nil,
        score: Int = 0,
        gameOver: Bool = false,
        hasGuessed: Bool = false
    ) {
        self.mode = mode
        self.randomness = randomness
        self.genre = genre
        
        _topItem = State(initialValue: topItem)
        _bottomItem = State(initialValue: bottomItem)
        _score = State(initialValue: score)
        _gameOver = State(initialValue: gameOver)
        _hasGuessed = State(initialValue: hasGuessed)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                if gameOver {
                    Spacer()
                    
                    Text("Game Over!")
                        .foregroundStyle(.red)
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    Button(action: {
                        restartGame()
                    }) {
                        Text("Play Again")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: 250)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                } else {
                    if initialLoad {
                        Spacer()
                        
                        Text("Loading...")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                    } else {
                        if let top = topItem {
                            ZStack {
                                VStack(spacing: 0) {
                                    // top
                                    ZStack {
                                        AsyncImage(url: URL(string: top.imageUrl)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 365, height: 365)
                                                .aspectRatio(1, contentMode: .fill)
                                                .blur(radius: 7)
                                                .clipped()
                                        } placeholder: {
                                            Color.black
                                        }
                                        .opacity(0.4)
                                        
                                        VStack {
                                            Spacer()
                                            
                                            HStack {
                                                Text(top.title)
                                                    .foregroundStyle(.white)
                                                    .font(.largeTitle)
                                                    .fontWeight(.bold)
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                            
                                            HStack {
                                                Text("By \(top.artist)")
                                                    .foregroundStyle(.white)
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                    .padding(.bottom, 5)
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                            
                                            Text("has")
                                                .foregroundStyle(.white)
                                                .fontWeight(.semibold)
                                                .padding(.top)
                                            
                                            Text(top.listens.formatted())
                                                .font(.system(size: 60))
                                                .fontWeight(.bold)
                                                .foregroundStyle(.yellow)
                                                .padding(.horizontal)
                                            
                                            Text("Listeners")
                                                .foregroundStyle(.white)
                                                .font(.title)
                                                .fontWeight(.semibold)
                                                .padding(.top, -33)
                                            
                                            Spacer()
                                        }
                                        .padding()
                                    }
                                    
                                    //bottom
                                    if let bottom = bottomItem {
                                        ZStack {
                                            AsyncImage(url: URL(string: bottom.imageUrl)) { phase in
                                                switch phase {
                                                case .empty:
                                                    Color.black
                                                    
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 365, height: 365)
                                                        .aspectRatio(1, contentMode: .fill)
                                                        .blur(radius: 7)
                                                        .clipped()
                                                        .onAppear {
                                                            bottomImageLoaded = true
                                                        }
                                                    
                                                case .failure:
                                                    Color.black
                                                    
                                                @unknown default:
                                                    Color.black
                                                }
                                            }
                                            .id(bottom.imageUrl)
                                            .opacity(0.4)
                                            
                                            VStack {
                                                Spacer()
                                                
                                                HStack {
                                                    Text(bottom.title)
                                                        .foregroundStyle(.white)
                                                        .font(.largeTitle)
                                                        .fontWeight(.bold)
                                                    
                                                    Spacer()
                                                }
                                                .padding(.horizontal)
                                                
                                                HStack {
                                                    Text("By \(bottom.artist)")
                                                        .foregroundStyle(.white)
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                        .padding(.bottom, 5)
                                                    
                                                    Spacer()
                                                }
                                                .padding(.horizontal)
                                                
                                                if hasGuessed {
                                                    Text("has")
                                                        .foregroundStyle(.white)
                                                        .fontWeight(.semibold)
                                                        .padding(.top)
                                                    
                                                    Text(bottom.listens.formatted())
                                                        .font(.system(size: 60))
                                                        .fontWeight(.bold)
                                                        .foregroundStyle(.yellow)
                                                        .padding(.horizontal)
                                                        .opacity(hasGuessed ? 1 : 0)
                                                        .animation(.easeIn(duration: 0.5), value: hasGuessed)
                                                    
                                                    Text("Listeners")
                                                        .foregroundStyle(.white)
                                                        .font(.title)
                                                        .fontWeight(.semibold)
                                                        .padding(.top, -33)
                                                    
                                                } else {
                                                    Text("has")
                                                        .foregroundStyle(.white)
                                                        .fontWeight(.semibold)
                                                        .padding(.top)
                                                    
                                                    HStack(spacing: 20) {
                                                        Button("Higher") {
                                                            guess(isHigher: true)
                                                        }
                                                        .padding()
                                                        .background(Color(red: 80/255, green: 170/255, blue: 50/255))
                                                        .foregroundStyle(.white)
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                        .cornerRadius(10)
                                                        
                                                        Button("Lower") {
                                                            guess(isHigher: false)
                                                        }
                                                        .padding()
                                                        .background(Color(red: 155/255, green: 120/255, blue: 180/255))
                                                        .foregroundStyle(.white)
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                        .cornerRadius(10)
                                                    }
                                                    .padding(.vertical, 5)
                                                    
                                                    Text("listeners than \(top.title)")
                                                        .foregroundStyle(.white)
                                                        .fontWeight(.semibold)
                                                }
                                                
                                                Spacer()
                                            }
                                            .opacity(bottomImageLoaded ? 1 : 0)
                                            .animation(.easeIn(duration: 0.3), value: bottomImageLoaded)
                                            .padding()
                                        }
                                    } else {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 365, height: 365)
                                            
                                            ProgressView()
                                        }
                                    }
                                }
                                
                                Rectangle()
                                    .fill(.black)
                                    .frame(width: 400, height: 30)
                                
                                Text("Vs.")
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 2)
                                    .font(.system(size: 60))
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.black))
                                
                            }
                        }
                    }
                }
                
                if !initialLoad {
                    HStack {
                        Text("Score: \(score)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
        }
        .onAppear {
            loadItems()
        }
        .navigationBarBackButtonHidden(!gameOver)
        .toolbar(gameOver ? .visible : .hidden)
    }
    
    func loadItems() {
        Task {
            topItem = await LastFMService.fetchRandomItem(mode: mode, randomness: randomness, genre: genre)
            bottomItem = await LastFMService.fetchRandomItem(mode: mode, randomness: randomness, genre: genre)
            
            initialLoad = false
        }
    }
    
    func guess(isHigher: Bool) {
        if let top = topItem, let bottom = bottomItem {
            hasGuessed = true
            
            let correct = bottom.listens > top.listens
            let equal = bottom.listens == top.listens
            
            if equal || (isHigher && correct) || (!isHigher && !correct) {
                score += 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    bottomItem = nil
                    bottomImageLoaded = false
                    
                    topItem = bottom
                    hasGuessed = false
                    
                    Task {
                        var newItem: GameItem? = nil
                        
                        repeat {
                            newItem = await LastFMService.fetchRandomItem(mode: mode, randomness: randomness, genre: genre)
                        } while newItem?.title == topItem?.title &&
                                newItem?.artist == topItem?.artist
                        
                        bottomItem = newItem
                    }
                }
                
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    gameOver = true
                }
            }
        }
    }
    
    func restartGame() {
        score = 0
        gameOver = false
        hasGuessed = false
        topItem = nil
        bottomItem = nil
        initialLoad = true
        
        loadItems()
    }
}

#Preview {
    GameView(
        mode: .track,
        randomness: 1,
        genre: "All",
        topItem: GameItem(
            title: "Don't Stand So Close To Me",
            artist: "The Police",
            listens: 2000000,
            imageUrl: ""
        ),
        bottomItem: GameItem(
            title: "Started From The Bottom",
            artist: "Drake",
            listens: 3000000,
            imageUrl: ""
        ),
        score: 5,
        hasGuessed: false
    )
}
