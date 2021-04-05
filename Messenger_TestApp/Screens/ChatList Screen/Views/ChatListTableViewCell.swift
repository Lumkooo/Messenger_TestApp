//
//  ChatListTableViewCell.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/5/21.
//

import UIKit

final class ChatListTableViewCell: UITableViewCell {

    // MARK: - Constants

    private enum Constants {

//        Элемент чата:
//            Заливка: 000000
//            Закругление: 8
//            Текст сообщения:
//                Цвет: FFFFFF
//                Шрифт: Системный жирный 18
//            Время:
//                Цвет: FFFFFF
//                Шрифт: Системный 13

        static let messageTextColor = UIColor(rgb: 0xFFFFFF)
        static let messageTextFont = UIFont.boldSystemFont(ofSize: 18)

        static let messageBackgroundColor = UIColor(rgb: 0x000000)
        static let messageCornerRadius: CGFloat = 8
        
        static let timeTextColor = UIColor(rgb: 0xFFFFFF)
        static let timeTextFont = UIFont.systemFont(ofSize: 13)
    }

    // MARK: - Properties

    static let reuseIdentifier = String(describing: self)

    // MARK: - Views

    private lazy var messageLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = Constants.messageTextColor
        myLabel.font = Constants.messageTextFont
        return myLabel
    }()

    private lazy var timeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = Constants.timeTextColor
        myLabel.font = Constants.timeTextFont
        return myLabel
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        self.setupElements()
        self.backgroundColor = Constants.messageBackgroundColor
        self.layer.cornerRadius = Constants.messageCornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public method

    func setupCell(messages: [Message]) {
        if !messages.isEmpty {
            self.messageLabel.text = messages[0].text
            self.timeLabel.text = messages[0].time
        }
    }
}

// MARK: - UISetup

private extension ChatListTableViewCell {
    func setupElements() {
        self.setupMessageLabel()
        self.setupTimeLabel()
    }

    func setupMessageLabel() {
        self.contentView.addSubview(self.messageLabel)
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.messageLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                       constant: AppConstants.Constraints.normal),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                       constant: -AppConstants.Constraints.normal),
            self.messageLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                                       constant: AppConstants.Constraints.half)
        ])
    }

    func setupTimeLabel() {
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.timeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                                       constant: -AppConstants.Constraints.normal),
            self.timeLabel.topAnchor.constraint(equalTo: self.messageLabel.bottomAnchor,
                                                       constant: AppConstants.Constraints.quarter),
            self.timeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                       constant: -AppConstants.Constraints.normal)
        ])
    }
}
