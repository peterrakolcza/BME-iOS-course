//
//  ContentView.swift
//  GeoMessenger
//
//  Created by Rakolcza Peter on 2021. 11. 14..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State var newMessage = ""
    
    var body: some View {
        VStack {
            List(networkManager.fetchedMessages) { message in
                if message.sender == "peterrakolcza" {
                    ListRowView(message: message)
                        .rotationEffect(.degrees(180))
                        .environment(\.layoutDirection, .rightToLeft)
                } else {
                    ListRowView(message: message)
                        .rotationEffect(.degrees(180))
                        .environment(\.layoutDirection, .leftToRight)
                }
            }
            .refreshable {
                self.networkManager.fetchMessages()
            }
            .rotationEffect(.degrees(180))
            .listStyle(.plain)
            
            TextField("New message", text: $newMessage)
                .onSubmit {
                    self.networkManager.sendMessage(message: newMessage, sender: "peterrakolcza")
                    self.newMessage = ""
                }
                .textFieldStyle(.roundedBorder)
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 2, trailing: 7))
        }
        .onAppear {
            self.networkManager.fetchMessages()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
