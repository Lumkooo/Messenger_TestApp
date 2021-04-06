//
//  Chat.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

final class Chat: Decodable, Encodable {

    // MARK: - Properties

    var id: String
    var messages: [Message]

    // MARK: - Init

    init(messages: [Message]) {
        self.id = UUID().uuidString
        self.messages = messages
    }

    init() {
        self.id = UUID().uuidString
        self.messages = []
    }

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id
        case messages
    }
}
