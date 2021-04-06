//
//  ChatResponse.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/6/21.
//

import Foundation

struct  ChatResponse: Decodable, Encodable {
    enum CodingKeys: String, CodingKey {
        case chats
    }
    let chats: [Chat]
}
