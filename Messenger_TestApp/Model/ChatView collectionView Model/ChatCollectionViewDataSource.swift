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
}

// MARK: UICollectionViewDataSource

extension ChatCollectionViewDataSource: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
