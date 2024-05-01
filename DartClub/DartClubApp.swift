//
//  DartClubApp.swift
//  DartClub
//
//  Created by Antoine on 25/03/2024.
//

import SwiftUI

@main
struct Dart_ClubApp: App {
    
//    init() {
            //Use this if NavigationBarTitle is with Large Font
//            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]

            //Use this if NavigationBarTitle is with displayMode = .inline
//        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Avenir-Heavy", size: 35)!]
//        }
    
    var body: some Scene {
        WindowGroup {
            LaunchViewV2().statusBar(hidden: true)
        }
    }
}
