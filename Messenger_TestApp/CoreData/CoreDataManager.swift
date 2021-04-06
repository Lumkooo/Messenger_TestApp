//
//  CoreDataManager.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/6/21.
//

import UIKit
import CoreData

final class CoreDataManager {

    // MARK: - Properties

    // Использование синглтона, чтобы на каждом из экранов не создавать экземпляр класса
    static let sharedInstance = CoreDataManager()
    private var chats: [CoreDataChat] = []
    private let context: NSManagedObjectContext

    // MARK: - Init

    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get appDelegate during Init")
        }
        self.context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CoreDataChat> = CoreDataChat.fetch()
        do {
            self.chats = try self.context.fetch(fetchRequest)
        } catch {
            // MARK: - Можно вывести ошибку пользователю
            assertionFailure("Can not fetch")
        }
    }

}

// MARK: - Работа с чатами

extension CoreDataManager {

    // MARK: - Добавление чата

    func insertChat(_ chat: Chat, atPosition position: Int) {
        let coreDataChat = CoreDataChat(context: self.context)
        coreDataChat.id = chat.id
        self.chats.insert(coreDataChat, at: position)
        do {
            try self.context.save()
        } catch {
            self.context.rollback()
            assertionFailure("Can not append chat")
        }
    }

    // MARK: - Удаление чата

    func removeChat(atIndex index: Int) -> Chat? {
        var chat: Chat?
        if self.chats.count > index {
            let messages = self.getMessagesForChat(atChatIndex: index)
            self.chats.remove(at: index)
            let fetchRequest: NSFetchRequest<CoreDataChat> = CoreDataChat.fetch()
            do {
                let entitie = try self.context.fetch(fetchRequest)[index]
                chat = Chat(messages: messages,
                            id: entitie.id)
                self.context.delete(entitie)
                try self.context.save()
            } catch {
                self.context.rollback()
                assertionFailure("Can not remove chat at index: \(index)")
            }
        } else {
            assertionFailure("Can not remove chat at index: \(index).\nIndex is out of range")
        }
        return chat
    }

    func getChats() -> [Chat] {
        var chats: [Chat] = []
        for (index, coreDataChat) in self.chats.enumerated() {
            let messages = self.getMessagesForChat(atChatIndex: index)
            let chat = Chat(messages: messages,
                            id: coreDataChat.id)
            chats.append(chat)
        }
        return chats
    }

    func getChat(for index: Int) -> Chat {
        var chat: Chat
        if self.chats.count > index {
            let coreDataChat = chats[index]
            var messages: [Message] = []
            if let coreDataMessages = coreDataChat.relationship {
                for coreDataMessage in coreDataMessages {
                    if let mess = coreDataMessage as? CoreDataMessage {
                        let message = Message(text: mess.text,
                                              time: mess.time,
                                              isOutgoing: mess.isOutgoing)
                        messages.append(message)
                    }
                }
            }
            chat = Chat(messages: messages, id: coreDataChat.id)
        } else {
            fatalError("Can not get chat at index: \(index).\nIndex is out of range")
        }
        return chat
    }
}

// MARK: - Работа с сообщениями

extension CoreDataManager {

    // MARK: - Добавление сообщения

    func appendMessage(_ message: Message, atChatIndex index: Int) {
        if self.chats.count <= index {
            self.insertChat(Chat(), atPosition: index)
        }

        let chat = chats[index]
        let coreDataMessage = CoreDataMessage(context: self.context)
        coreDataMessage.relationship = chat
        coreDataMessage.text = message.text
        coreDataMessage.time = message.time
        coreDataMessage.isOutgoing = message.isOutgoing
        chat.addToRelationship(coreDataMessage)
        do {
            try self.context.save()
        } catch {
            self.context.rollback()
            assertionFailure("Can not append message")
        }
    }

//    func saveMessages( _ messages: [Message], atChatIndex index) {
//        if self.chats.count > index {
//            let chat = chats[index]
//            let coreDataMessage = CoreDataMessage(context: self.context)
//            coreDataMessage.relationship = chat
//            coreDataMessage.text = message.text
//            coreDataMessage.time = message.time
//            coreDataMessage.isOutgoing = message.isOutgoing
//            chat.addToRelationship(coreDataMessage)
//            do {
//                try self.context.save()
//            } catch {
//                self.context.rollback()
//                assertionFailure("Can not append message")
//            }
//        } else {
//            fatalError("Can not append message at chat with index: \(index).\nIndex is out of range")
//        }
//    }

    // MARK: - Получение списка сообщений

    func getMessagesForChat(atChatIndex index: Int) -> [Message] {
        if self.chats.count > index {
            var messages: [Message] = []
            let coreDataChat = chats[index]
            guard let coreDataMessages = coreDataChat.relationship?.allObjects as? [CoreDataMessage] else {
                fatalError("oops, error during getting messages")
            }
            for coreDataMessage in coreDataMessages {
                let message = Message(text: coreDataMessage.text,
                                      time: coreDataMessage.time,
                                      isOutgoing: coreDataMessage.isOutgoing)
                messages.append(message)
            }
            return messages
        } else {
            fatalError("Can not get messages at chat with index: \(index).\nIndex is out of range")
        }
    }
}
