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
        return self.messages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MyCell
        cell.label.text = self.messages[indexPath.item].text
        return cell
    }
}
