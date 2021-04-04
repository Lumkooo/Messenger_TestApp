//
//  ChatInteractor.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatInteractor {
    func loadInitData()
}

protocol IChatInteractorOuter: AnyObject {
    func showMessages(_ messages: [Message])
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
        self.chat.messages.append(Message(text: "Привет, я бы хотел кое-что написать. Немного текста, который я бы хотел увидеть чуточку позже.one",
                                          time: "15:30",
                                          isOutgoing: false))
        self.chat.messages.append(Message(text: "Привет, я бы хотел кое-что написать. Немного ",
                                          time: "15:30",
                                          isOutgoing: true))
        self.chat.messages.append(Message(text: "Привет, я бы хотел кое-что написать. Немного текста, который я бы хотел увидеть чуточку позже. Немного больше и готово! И еще чуточку добавить! Хопа! хех =) What if i'll write something else?Привет, я бы хотел кое-что написать. Немного текста, который я бы хотел увидеть чуточку позже. Немного больше и готово! И еще чуточку добавить! Хопа! хех =) What if i'll write something else?",
                                          time: "15:30",
                                          isOutgoing: false))
        self.chat.messages.append(Message(text: "Немного больше и готово! И еще чуточку добавить",
                                          time: "15:30",
                                          isOutgoing: true))
        self.chat.messages.append(Message(text: "Second one",
                                          time: "15:30",
                                          isOutgoing: false))
        self.chat.messages.append(Message(text: "third One",
                                          time: "15:30",
                                          isOutgoing: true))
        self.chat.messages.append(Message(text: "okay",
                                          time: "15:30",
                                          isOutgoing: false))

        self.presenter?.showMessages(self.chat.messages)
    }
}
