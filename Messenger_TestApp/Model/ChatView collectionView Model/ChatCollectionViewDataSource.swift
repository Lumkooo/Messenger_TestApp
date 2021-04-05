//
//  ChatCollectionViewDataSource.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

final class ChatCollectionViewDataSource: NSObject {

    // MARK: Properties

    private(set) var messages: [Message] = []

    // MARK: - Методы для работы с сообщениями

    func setData(messages: [Message]) {
        self.messages = messages
    }

    func appendMessage( _ message: Message) {
        self.messages.append(message)
    }
}

// MARK: UICollectionViewDataSource

extension ChatCollectionViewDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        print("WTF: ",self.messages.count)
        return self.messages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("And please: ",self.messages.count)
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ChatViewCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ChatViewCollectionViewCell
        else {
            fatalError("Can't dequeue reusable cell")
        }
        let message = self.messages[indexPath.row]
        cell.setupCell(message: message)

        return cell
    }
}
