//
//  Chat.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

final class Chat {

    // MARK: - Properties

    var id: String
    var messages: [Message]

    // MARK: - Init

    init(messages: [Message], id: String) {
        self.id = id
        self.messages = messages
    }

    init(messages: [Message]) {
        self.id = UUID().uuidString
        self.messages = messages
    }

    init() {
        self.id = UUID().uuidString
        self.messages = []
    }
}
