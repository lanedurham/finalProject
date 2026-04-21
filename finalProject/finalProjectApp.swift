//
//  finalProjectApp.swift
//  finalProject
//
//  Created by Lane Durham on 4/20/26.
//

import SwiftUI

@main
struct finalProjectApp: App {
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .normal
        )
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.black],
            for: .selected
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
