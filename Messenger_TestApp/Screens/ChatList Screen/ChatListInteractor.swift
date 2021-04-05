//
//  ChatListInteractor.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatListInteractor {
    func loadInitData()
    func didSelectCellAt(indexPath: IndexPath)
    func addChatTapped()
    func removeChatAt(_ indexPath: IndexPath)
}

protocol IChatListInteractorOuter: AnyObject {
    func showChats(_ chats: [Chat])
    func appendChat(_ chat: Chat)
    func goToChat(delegate: IChatListInteractorDelegate)
    func goToChat(_ chat: Chat, delegate: IChatListInteractorDelegate)
    func removeChatFrom(index: Int)
}

protocol IChatListInteractorDelegate {
    func saveChat(_ chat: Chat, isChatChaged: Bool)
}

final class ChatListInteractor {

    // MARK: - Properties

    weak var presenter: IChatListInteractorOuter?
    private var chats: [Chat] = []

}

// MARK: - IChatListInteractor

extension ChatListInteractor: IChatListInteractor {
    func loadInitData() {
        self.chats.append(Chat(messages: [Message(text: "Hello!", time: "12:00", isOutgoing: true)]))
        self.chats.append(Chat(messages: [Message(text: "Goodbye!", time: "11:45", isOutgoing: true)]))
        self.chats.append(Chat(messages: [Message(text: "Okay!", time: "12:55", isOutgoing: true),
                                          Message(text: "Lhm!", time: "12:55", isOutgoing: true),
                                          Message(text: "HHHH!", time: "12:55", isOutgoing: true),
                                          Message(text: "Zzzzzzzzz...!", time: "12:55", isOutgoing: false)]))
        self.presenter?.showChats(self.chats)
    }

    func didSelectCellAt(indexPath: IndexPath) {
        if self.chats.count > indexPath.row {
            let chat = self.chats[indexPath.row]
            self.presenter?.goToChat(chat, delegate: self)
        }
    }

    func addChatTapped() {
        self.presenter?.goToChat(delegate: self)
    }

    func removeChatAt(_ indexPath: IndexPath) {
        if self.chats.count > indexPath.row {
            self.chats.remove(at: indexPath.row)
        }
    }
}

// MARK: - IChatListInteractorDelegate

extension ChatListInteractor: IChatListInteractorDelegate {
    func saveChat(_ chat: Chat, isChatChaged: Bool) {

        if self.isChatExisted(chat) {
            let indexOfChat = self.chats.firstIndex { (existingChat) -> Bool in
                existingChat.id == chat.id
            }
            guard let index = indexOfChat else {
                return
            }

            if isChatChaged {
                // Чат был изменен
                if index == 0 {
                    // Чат и так был первый, не надо ничего с ним делать
                    return
                }
                let chat = self.chats.remove(at: index)
                self.presenter?.removeChatFrom(index: index)
                self.insertChatAtFirstPosition(chat)
            } else {
                // Чат не был изменен
            }
        } else {
            self.insertChatAtFirstPosition(chat)
        }
    }
}

private extension ChatListInteractor {
    func isChatExisted(_ chat: Chat) -> Bool {
        self.chats.contains(where: { (existingChat) -> Bool in
            existingChat.id == chat.id
        })
    }

    func insertChatAtFirstPosition(_ chat: Chat) {
        self.chats.insert(chat, at: 0)
        self.presenter?.appendChat(chat)
    }
}
