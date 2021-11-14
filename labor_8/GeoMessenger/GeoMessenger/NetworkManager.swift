//
//  NetworkManager.swift
//  GeoMessenger
//
//  Created by Rakolcza Peter on 2021. 11. 14..
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var fetchedMessages = [Message]()
    
    func fetchMessages() {
        let urlString = "http://5glab.educationhost.cloud/igniter/public/messages"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let data = data{
                        do{
                            let messages = try
                            decoder.decode(Array<Message>.self, from: data)
                            DispatchQueue.main.async {
                                self.fetchedMessages = messages
                            }
                        } catch{
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func sendMessage(message: String, sender: String){
        let message = Message(id:2, sender: sender, content: message)
        let encoder = JSONEncoder()
        
        guard let jsonData = try? encoder.encode(message) else { return }
        
        let url = URL(string: "http://5glab.educationhost.cloud/igniter/public/messages/add")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        session.uploadTask(with: request, from: jsonData) { data, response, error in
            if let error = error {
                print(error)
                return
            } else {
                self.fetchMessages()
            }
        }.resume()
    }
}
