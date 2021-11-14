//
//  Message.swift
//  GeoMessenger
//
//  Created by Rakolcza Peter on 2021. 11. 14..
//

import Foundation

struct Message: Identifiable, Codable {
    var id: Int
    var sender: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case id = "message_id"
        case sender = "from_user"
        case content
    }
}
