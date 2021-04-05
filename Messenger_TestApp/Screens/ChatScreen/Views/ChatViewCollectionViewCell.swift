//
//  ChatViewCollectionViewCell.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

final class ChatViewCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {

//        Элемент чата исходящий (Справа):
//            Заливка: D9D8D8
//            Закругление: 4
//            Тень:
//                Цвет: 000000
//                Прозрачность: 0.5
//                Отступ: 0,2
//                Радиус: 4
//            Текст сообщения:
//                Цвет: FFFFFF
//                Шрифт: Системный курсив 15
//            Время:
//                Цвет: 000000
//                Шрифт: Системный 11

        static let outgoingMessageBackgroundColor = UIColor(rgb: 0xD9D8D8)
        static let outgoingMessageCornerRadius: CGFloat = 4
        static let outgoingMessageShadowColor = UIColor(rgb: 0x000000).cgColor
        static let outgoingMessageShadowOpacity: Float = 0.5
        static let outgoingMessageShadowOffset: CGSize = CGSize(width: 0, height: 2)
        static let outgoingMessageShadowRadius: CGFloat = 4
        static let outgoingMessageTextColor = UIColor(rgb: 0xFFFFFF)
        static let outgoingMessageFont = UIFont.italicSystemFont(ofSize: 15)

//        Элемент чата входищий (Слева):
//            Заливка: FFFFFF
//            Закругление: 4
//            Тень:
//                Цвет: 000000
//                Прозрачность: 0.5
//                Отступ: 0,2
//                Радиус: 4
//            Текст сообщения:
//                Цвет: 000000
//                Шрифт: Системный 15
//            Время:
//                Цвет: 000000
//                Шрифт: Системный 11

        static let incomingMessageBackgroundColor = UIColor(rgb: 0xFFFFFF)
        static let incomingMessageCornerRadius: CGFloat = 4
        static let incomingMessageShadowColor = UIColor(rgb: 0x000000).cgColor
        static let incomingMessageShadowOpacity: Float = 0.5
        static let incomingMessageShadowOffset: CGSize = CGSize(width: 0, height: 2)
        static let incomingMessageShadowRadius: CGFloat = 4
        static let incomingMessageTextColor = UIColor(rgb: 0x000000)
        static let incomingMessageFont = UIFont.systemFont(ofSize: 15)

        static let messageTimeTextColor = UIColor(rgb: 0x000000)
        static let messageTimeFont = UIFont.systemFont(ofSize: 11)
    }

    // MARK: - Views

    private lazy var messageContainerView: UIView = {
        let myView = UIView()
        return myView
    }()

    private lazy var messageLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 0
        return myLabel
    }()

    private lazy var timeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = Constants.messageTimeTextColor
        myLabel.font = Constants.messageTimeFont
        return myLabel
    }()


    // MARK: - Properties

    static let reuseIdentifier = String(describing: self)
    private lazy var outgoingMessageContainerViewConstraints = [
        self.messageContainerView.leadingAnchor.constraint(
            equalTo: self.contentView.leadingAnchor,
            constant: self.frame.width/2),
        self.messageContainerView.trailingAnchor.constraint(
            equalTo: self.contentView.trailingAnchor,
            constant: -AppConstants.Constraints.normal)]
    private lazy var incomingMessageContainerViewConstraints = [
        self.messageContainerView.leadingAnchor.constraint(
            equalTo: self.contentView.leadingAnchor,
            constant: AppConstants.Constraints.normal),
        self.messageContainerView.trailingAnchor.constraint(
            equalTo: self.contentView.trailingAnchor,
            constant: -self.frame.width/2)]
    private lazy var outgoingMessageTimeConstraints = [
        self.timeLabel.trailingAnchor.constraint(
            equalTo: self.messageContainerView.leadingAnchor,
            constant: -AppConstants.Constraints.normal),
        self.timeLabel.bottomAnchor.constraint(
            equalTo: self.messageContainerView.bottomAnchor)]
    private lazy var incomingMessageTimeConstraints = [
        self.timeLabel.leadingAnchor.constraint(
            equalTo: self.messageContainerView.trailingAnchor,
            constant: AppConstants.Constraints.normal),
        self.timeLabel.bottomAnchor.constraint(
            equalTo: self.messageContainerView.bottomAnchor)
    ]

    var hello: String = ""


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupMutualElements()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Error...")
    }

    // MARK: - Public method

    func setupCell(message: Message) {
        if message.isOutgoing {
            self.setupOutgoingElements()
        } else {
            self.setupIncomingElements()
        }
        self.messageLabel.text = message.text
        self.timeLabel.text = message.time
    }

    // MARK: - preferredLayoutAttributesFitting

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        self.messageLabel.preferredMaxLayoutWidth = self.frame.width - 2*AppConstants.Constraints.normal - self.frame.width/2
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
        return layoutAttributes
    }
}

// MARK: - UISetup

private extension ChatViewCollectionViewCell {
    func setupMutualElements() {
        self.contentView.addSubview(self.messageContainerView)
        self.messageContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.messageContainerView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: AppConstants.Constraints.quarter),
            self.messageContainerView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: AppConstants.Constraints.quarter),
            self.messageContainerView.heightAnchor.constraint(
                greaterThanOrEqualToConstant: 0)
        ])
        self.setupMessageLabel()
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupOutgoingElements() {
        self.setupOutgoingMessageView()
        self.setupOutgoingMessageTime()
        self.setupOutgoingAppearence()
    }

    func setupOutgoingAppearence() {
        self.messageContainerView.backgroundColor = Constants.outgoingMessageBackgroundColor
        self.messageContainerView.layer.cornerRadius = Constants.outgoingMessageCornerRadius
        self.messageContainerView.layer.shadowColor = Constants.outgoingMessageShadowColor
        self.messageContainerView.layer.shadowOpacity = Constants.outgoingMessageShadowOpacity
        self.messageContainerView.layer.shadowOffset = Constants.outgoingMessageShadowOffset
        self.messageContainerView.layer.shadowRadius = Constants.outgoingMessageShadowRadius
        self.messageLabel.textColor = Constants.outgoingMessageTextColor
        self.messageLabel.font = Constants.outgoingMessageFont
    }

    func setupOutgoingMessageView() {
        NSLayoutConstraint.deactivate(self.incomingMessageContainerViewConstraints)
        NSLayoutConstraint.activate(self.outgoingMessageContainerViewConstraints)
    }

    func setupOutgoingMessageTime() {
        NSLayoutConstraint.deactivate(self.incomingMessageTimeConstraints)
        NSLayoutConstraint.activate(self.outgoingMessageTimeConstraints)
    }

    func setupIncomingElements() {
        self.setupIncomingMessageView()
        self.setupIncomingMessageTime()
        self.setupIncomingAppearence()
    }

    func setupIncomingAppearence() {
        self.messageContainerView.backgroundColor = Constants.incomingMessageBackgroundColor
        self.messageContainerView.layer.cornerRadius = Constants.incomingMessageCornerRadius
        self.messageContainerView.layer.shadowColor = Constants.incomingMessageShadowColor
        self.messageContainerView.layer.shadowOpacity = Constants.incomingMessageShadowOpacity
        self.messageContainerView.layer.shadowOffset = Constants.incomingMessageShadowOffset
        self.messageContainerView.layer.shadowRadius = Constants.incomingMessageShadowRadius
        self.messageLabel.textColor = Constants.incomingMessageTextColor
        self.messageLabel.font = Constants.incomingMessageFont
    }

    func setupIncomingMessageView() {
        NSLayoutConstraint.deactivate(self.outgoingMessageContainerViewConstraints)
        NSLayoutConstraint.activate(self.incomingMessageContainerViewConstraints)
    }

    func setupIncomingMessageTime() {
        NSLayoutConstraint.deactivate(self.outgoingMessageTimeConstraints)
        NSLayoutConstraint.activate(self.incomingMessageTimeConstraints)
    }

    func setupMessageLabel() {
        self.messageContainerView.addSubview(self.messageLabel)
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.messageLabel.topAnchor.constraint(
                equalTo: self.messageContainerView.topAnchor,
                constant: AppConstants.Constraints.quarter),
            self.messageLabel.leadingAnchor.constraint(
                equalTo: self.messageContainerView.leadingAnchor,
                constant: AppConstants.Constraints.half),
            self.messageLabel.trailingAnchor.constraint(
                equalTo: self.messageContainerView.trailingAnchor,
                constant: -AppConstants.Constraints.half),
            self.messageLabel.bottomAnchor.constraint(
                equalTo: self.messageContainerView.bottomAnchor,
                constant: -AppConstants.Constraints.quarter)
        ])
    }
}
