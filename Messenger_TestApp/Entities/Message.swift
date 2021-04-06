//
//  Message.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

final class Message: Decodable, Encodable {

    // MARK: - Properties

    var text: String
    var time: String
    // isOutgoing - Исходящее от пользователя?
    // Используется для определения того, чье это сообщение - ваше или вашего собеседника
    var isOutgoing: Bool

    // MARK: - Init

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        self.time = try container.decode(String.self, forKey: .time)
        self.isOutgoing = try container.decode(Bool.self, forKey: .isOutgoing)
    }

    init(text: String, time: String, isOutgoing: Bool) {
        self.text = text
        self.time = time
        self.isOutgoing = isOutgoing
    }

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case text
        case time
        case isOutgoing
    }
}


extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return (lhs.time == rhs.time && lhs.text == lhs.text)
    }
}
