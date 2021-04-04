//
//  Chat.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

final class Chat {

    // MARK: - Properties

    var messages: [Message]

    // MARK: - Init

    init(messages: [Message]) {
        self.messages = messages
    }

    init() {
        self.messages = []
    }
}
