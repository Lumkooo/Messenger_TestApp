//
//  ChatInteractor.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatInteractor {
    func saveChat()
    func loadInitData()
    func getMessagesCont() -> Int
    func appendTextToChat(_ messageText: String)
}

protocol IChatInteractorOuter: AnyObject {
    func showMessages(_ messages: [Message])
    func appendMessage(_ message: Message, atRow row: Int)
}

final class ChatInteractor {

    // MARK: - Properties

    private var chat: Chat
    private var isChatChanged = false
    private let delegate: IChatListInteractorDelegate
    weak var presenter: IChatInteractorOuter?

    // MARK: - Init

    init(chat: Chat, delegate: IChatListInteractorDelegate) {
        self.chat = chat
        self.delegate = delegate
    }
}

// MARK: - IChatInteractor

extension ChatInteractor: IChatInteractor {
    func loadInitData() {
        self.presenter?.showMessages(self.chat.messages)
    }

    func getMessagesCont() -> Int {
        return self.chat.messages.count
    }

    func appendTextToChat(_ messageText: String) {
        let trimmedMessage = self.trimmText(messageText)
        if trimmedMessage.isEmpty {
            return
        }
        let time = self.getCurrentTime()
        let isOutgoing = self.isMessageOutgoing()

        let message = Message(text: trimmedMessage,
                              time: time,
                              isOutgoing: isOutgoing)
        self.chat.messages.append(message)
        self.isChatChanged = true
        self.presenter?.appendMessage(message, atRow: self.chat.messages.count)
    }

    func saveChat() {
        if self.isChatChanged {
            self.delegate.saveChat(self.chat)
        }
    }
}

private extension ChatInteractor {
    func getCurrentTime() -> String {
        let date = Date()
        var time = ""
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        if minutes < 10 {
            time = "\(hour):0\(minutes)"
        } else {
            time = "\(hour):\(minutes)"
        }
        return time
    }

    // 11. Набранный текст рандомно присваивается либо получателю либо отправителю и добавляется в чат.

    func isMessageOutgoing() -> Bool {
        return arc4random_uniform(2) == 0
    }

//    12. Набранное сообщение должно обрезаться от пробелов и переходов на новую строку с начала и с конца. Если сообщение пустое оно отправляться не должно.

    func trimmText(_ text: String) -> String {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedText
    }
}
