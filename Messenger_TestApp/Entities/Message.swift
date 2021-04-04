//
//  Message.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

final class Message {

    // MARK: - Properties

    var text: String
    var time: String
    // isOutgoing - Исходящее от пользователя?
    // Используется для определения того, чье это сообщение - ваше или вашего собеседника
    var isOutgoing: Bool

    // MARK: - Init

    init(text: String, time: String, isOutgoing: Bool) {
        self.text = text
        self.time = time
        self.isOutgoing = isOutgoing
    }
}
