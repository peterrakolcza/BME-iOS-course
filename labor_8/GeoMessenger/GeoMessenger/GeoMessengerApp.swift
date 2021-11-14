//
//  GeoMessengerApp.swift
//  GeoMessenger
//
//  Created by Rakolcza Peter on 2021. 11. 14..
//

import SwiftUI

var messages: [Message] = [Message(id: 1, sender:"Joe", content: "First Message"),
                           Message(id: 2, sender:"Joe", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."), Message(id: 3, sender:"Teo", content: "Third Message")]

@main
struct GeoMessengerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
