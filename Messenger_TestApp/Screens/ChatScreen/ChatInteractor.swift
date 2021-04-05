//
//  ChatInteractor.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatInteractor {
    func loadInitData()
    func appendTextToChat(_ messageText: String)
    func getMessagesCont() -> Int
}

protocol IChatInteractorOuter: AnyObject {
    func showMessages(_ messages: [Message])
    func appendMessage(_ message: Message, atRow row: Int)
}


final class ChatInteractor {

    // MARK: - Properties

    private var chat: Chat
    weak var presenter: IChatInteractorOuter?

    // MARK: - Init

    init(chat: Chat) {
        self.chat = chat
    }
}

// MARK: - IChatInteractor

extension ChatInteractor: IChatInteractor {
    func loadInitData() {
        self.chat.messages.append(Message(text: "Привет, я бы хотел кое-что написать. Немного текста, который я бы хотел увидеть чуточку позже. Немного больше и готово! И еще чуточку добавить! Хопа! хех =) What if i'll write something else?",
                                          time: "15:30",
                                          isOutgoing: true))
//        self.chat.messages.append(Message(text: "Привет, я бы хотел кое-что написать. Немного текста, который я бы хотел увидеть чуточку позже.one",
//                                          time: "15:30",
//                                          isOutgoing: false))
//        self.chat.messages.append(Message(text: "Привет, я бы хотел кое-что написать. Немного ",
//                                          time: "15:30",
//                                          isOutgoing: true))
//        self.chat.messages.append(Message(text: "Привет, я бы хотел кое-что написать. Немного текста, который я бы хотел увидеть чуточку позже. Немного больше и готово! И еще чуточку добавить! Хопа! хех =) What if i'll write something else?Привет, я бы хотел кое-что написать. Немного текста, который я бы хотел увидеть чуточку позже. Немного больше и готово! И еще чуточку добавить! Хопа! хех =) What if i'll write something else?",
//                                          time: "15:30",
//                                          isOutgoing: false))
//        self.chat.messages.append(Message(text: "Немного больше и готово! И еще чуточку добавить",
//                                          time: "15:30",
//                                          isOutgoing: true))
//        self.chat.messages.append(Message(text: "Second one",
//                                          time: "15:30",
//                                          isOutgoing: false))
//        self.chat.messages.append(Message(text: "third One",
//                                          time: "15:30",
//                                          isOutgoing: true))
//        self.chat.messages.append(Message(text: "okay",
//                                          time: "15:30",
//                                          isOutgoing: false))

        self.presenter?.showMessages(self.chat.messages)
    }

    func getMessagesCont() -> Int {
        return self.chat.messages.count
    }

    func appendTextToChat(_ messageText: String) {
        let time = self.getCurrentTime()
        let isOutgoing = self.isMessageOutgoing()
        let message = Message(text: messageText,
                              time: time,
                              isOutgoing: isOutgoing)
        self.chat.messages.append(message)
        self.presenter?.appendMessage(message, atRow: self.chat.messages.count)
    }
}

private extension ChatInteractor {
    func getCurrentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let time = "\(hour):\(minutes)"
        return time
    }

    // 11. Набранный текст рандомно присваивается либо получателю либо отправителю и добавляется в чат.

    func isMessageOutgoing() -> Bool {
        return arc4random_uniform(2) == 0
    }
}
