//
//  ChatListView.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatListView: AnyObject {

}

final class ChatListView: UIView {

    // MARK: - Views

    private lazy var emptyChatLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "На данный момент чаты отсутствуют.\nМожете создать новый, нажав на \" + \" в правом верхнем углу "
        myLabel.font = .systemFont(ofSize: 18, weight: .bold)
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0
        return myLabel
    }()

    // MARK: - Properties

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IChatListView

extension ChatListView: IChatListView {

}

// MARK: - UISetup

private extension ChatListView {
    func setupElements() {
        self.setupEmtpyChatsLabel()
    }

    func setupEmtpyChatsLabel() {
        self.addSubview(self.emptyChatLabel)
        self.emptyChatLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.emptyChatLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.emptyChatLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                         constant: AppConstants.Constraints.normal),
            self.emptyChatLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                         constant: -AppConstants.Constraints.normal),
        ])
    }
}
