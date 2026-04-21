# HIGHER/LOWER (Music)

## Description
HIGHER/LOWER is a game where the user must guess whether a song has more listeners than another, seeing how many in a row they can guess correctly. The app pulls real music data from Last.fm and Deezer.

**Tools Used:**
- Xcode
- SwiftUI
- Last.fm API (music data)
- Deezer API (album artwork)

---

## Features
- Difficulty system (randomness levels within artists' catalogs)
- Genre selection (Pop, Rock, Hip Hop, Country, All)
- Real listener data from Last.fm API
- Album artwork pulled from Deezer API
- Endless gameplay with randomized music comparisons
- Score tracking

---

## Demo

### Screenshots
![Home Screen](images/higherlowerhome.png)
![Game Screen 1](images/higherlower1.png)
![Game Screen 2](images/higherlower2.png)

### Video
https://github.com/user-attachments/assets/a768c746-51c2-47ec-abb9-dbd4f36cb892

---

## Obstacles
While developing this app, I ran into two major problems, eventually coming up with a solution for each.

ISSUE 1: Randomly chosen songs were way too obscure.
- SOLUTION: This app uses Last.fm's track search feature, which returns up to 30 tracks per page. Each search requires a query, which will return songs most relevant to the query. At first, I was using single letters and common words (like "love"), but the songs it returned were almost always unknown with little to no listeners. To fix this, I noticed that inputting artists' names as the queries would return a list of songs relevant to them, so I instead made separate lists (by genre) of famous artists.

ISSUE 2: Song pictures were not available.
- SOLUTION: While 'image' was a subset of Last.fm's track search API, for some reason it always returned a gray star, no matter the song. To fix this, I discovered Deezer's search API, which did have accurate album artwork for specific songs. By making the search query the song title and artist name, I was able to retreive mostly accurate album artwork for the randomly selected songs.
---

## Future Improvements
In the future, I would love to add different modes (keeping genres and difficulty) that expand beyond just songs. In fact, I originally planned to have a separate mode for comparing albums' listeners, even setting it up throughout the entire project, but unfortunately Last.fm's search API did not return listener counts for albums. I would also like another mode that compares artists' popularity, whether through monthly listeners, stream counts, etc. Finally, overall making the app look more professional would defenitely need to happen in the future.
