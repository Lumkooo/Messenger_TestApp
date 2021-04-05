//
//  ChatView.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatView: AnyObject {
    var sendButtonTapedWith: ((String)-> Void)? { get set }

    func showMessages(_ messages: [Message])
    func scrollCollectionView(toRow row: Int)
    func appendMessage(_ message: Message, atRow row: Int)
}

final class ChatView: UIView {

    // MARK: - Constants

    private enum Constants {

        //        Заливка: F4F3F3
        static let backgroundColor = UIColor(rgb: 0xF4F3F3)

        static let messageTextViewAnimationDuration: Double = 0.3
        static let messageTextViewPlaceholder = "Введите сообщение..."

//        Тулбар ввода сообщения:
//            Заливка: FFFFFF
//            Тень:
//                Цвет: 000000
//                Прозрачность: 0.5
//                Отступ: 0,2
//                Радиус: 4
//            Цвет кнопки отправить: E11C28
//            Область ввода сообщения:
//                Заливка: E7E7E7
//                Скругление: 5
//                Текст:
//                    Цвет: 000000
//                    Шрифт: Системный 17
//                    Заглушка:
//                        Цвет: 000000
//                        Прозрачность: 0.3
//                        Шрифт: Системный жирный 17

        static let messageToolbarBackgroundColor = UIColor(rgb: 0xFFFFFF)
        static let messageToolbarShadowColor = UIColor(rgb: 0x000000).cgColor
        static let messageToolbarShadowOpacity: Float = 0.5
        static let messageToolbarShadowOffset: CGSize = CGSize(width: 0, height: 2)
        static let messageToolbarShadowRadius: CGFloat = 4
        static let sendButtonColor = UIColor(rgb: 0xE11C28)
        static let messageTextViewBackgroundColor = UIColor(rgb: 0xE7E7E7)
        static let messageTextViewCornerRadius: CGFloat = 5
        static let messageTextViewTextColor = UIColor(rgb: 0x000000)
        static let messageTextViewOpacity: Float = 1
        static let messageTextViewFont = UIFont.systemFont(ofSize: 17)
        static let messageTextViewDummyOpacity: Float = 0.3
        static let messageTextViewDummyFont = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    // MARK: - Views

    private let collectionView: UICollectionView = {
        let myCollectionView:UICollectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: UICollectionViewFlowLayout.init())
        myCollectionView.register(ChatViewCollectionViewCell.self,
                                  forCellWithReuseIdentifier: ChatViewCollectionViewCell.reuseIdentifier)
        myCollectionView.backgroundColor = Constants.backgroundColor
        myCollectionView.keyboardDismissMode = .interactive
        return myCollectionView
    }()

    private lazy var messageTextView: UITextView = {
        let myTextView = UITextView()
        myTextView.delegate = self
        myTextView.text = Constants.messageTextViewPlaceholder
        myTextView.backgroundColor = Constants.messageTextViewBackgroundColor
        myTextView.layer.cornerRadius = Constants.messageTextViewCornerRadius
        myTextView.textColor = Constants.messageTextViewTextColor
        myTextView.layer.opacity = Constants.messageTextViewDummyOpacity
        myTextView.font = Constants.messageTextViewFont
        return myTextView
    }()

    private lazy var sendButton: UIButton = {
        let myButton = UIButton()
        myButton.addTarget(self,
                           action: #selector(self.sendButtonTapped(gesture:)),
                           for: .touchUpInside)
        let tintedImage = AppConstants.Images.iconSend?.withRenderingMode(.alwaysTemplate)
        myButton.setImage(tintedImage, for: .normal)
        myButton.tintColor = Constants.sendButtonColor
        return myButton
    }()

    private lazy var messageToolbarView: UIView = {
        let myView = UIView()
        myView.backgroundColor = Constants.messageToolbarBackgroundColor
        myView.layer.shadowColor = Constants.messageToolbarShadowColor
        myView.layer.shadowOpacity = Constants.messageToolbarShadowOpacity
        myView.layer.shadowOffset = Constants.messageToolbarShadowOffset
        myView.layer.shadowRadius = Constants.messageToolbarShadowRadius
        return myView
    }()

    override var inputAccessoryView: UIView? {
        return self.messageToolbarView
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: - Properties

    // Высота textView при 4 строках равна:
    private lazy var maxTextHeight: CGFloat = self.heightForString(line: "Hello\nHello\nHello\nHello")
    // Высота textView при одной строке равна:
    private lazy var minTextHeight: CGFloat = self.heightForString(line: "Hello")

    private lazy var textViewHeightConstraint = self.messageTextView.heightAnchor.constraint(
        equalToConstant: self.heightForString(line: "Hello"))
    private lazy var textViewBottomConstraint = self.messageTextView.bottomAnchor.constraint(
        equalTo: self.safeAreaLayoutGuide.bottomAnchor)
    private lazy var sendButtonBottomConstraint = self.sendButton.bottomAnchor.constraint(
        equalTo: self.safeAreaLayoutGuide.bottomAnchor,
        constant: -AppConstants.Constraints.half)

    private var collectionViewDataSource = ChatCollectionViewDataSource()
    var sendButtonTapedWith: ((String)-> Void)?


    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width,
                                          height: 10)
        return layout
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.setupNotifications()
        self.setupTapToHideKeyboard()
        self.backgroundColor = Constants.backgroundColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Обработка нажатия на кнопку

    @objc private func sendButtonTapped(gesture: UIGestureRecognizer) {
        guard let text = self.messageTextView.text else {
            return
        }
        self.sendButtonTapedWith?(text)
        self.setupMessageTextViewPlaceholder()
        self.resizeTextViewToFitText()
        self.dismissKeyboard()
    }
}

// MARK: - IChatView

extension ChatView: IChatView {
    func showMessages(_ messages: [Message]) {
        // TODO: - FIX!
        self.collectionView.collectionViewLayout = self.layout
        self.collectionViewDataSource.setData(messages: messages)
        self.collectionView.reloadData()
    }

    func scrollCollectionView(toRow row: Int) {
        self.collectionView.scrollToItem(at: IndexPath(row: row-1,
                                                       section: 0),
                                         at: .bottom,
                                         animated: true)
    }

    func appendMessage(_ message: Message, atRow row: Int) {
        self.collectionViewDataSource.appendMessage(message)
        self.collectionView.reloadData()
    }
}

// MARK: - UISetup

private extension ChatView {
    func setupElements() {
        self.setupSendButton()
        self.setupMessageTextView()
        self.setupCollectionView()
        self.setupSafeAreaBackgroundView()
    }

    func setupSendButton() {
        self.addSubview(self.sendButton)
        self.sendButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.sendButtonBottomConstraint,
            self.sendButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -AppConstants.Constraints.half),
            self.sendButton.heightAnchor.constraint(equalToConstant: self.minTextHeight),
            self.sendButton.widthAnchor.constraint(equalTo: self.sendButton.heightAnchor)
        ])
    }

    func setupMessageTextView() {
        self.addSubview(self.messageTextView)
        self.messageTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.messageTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                          constant: AppConstants.Constraints.half),
            self.messageTextView.trailingAnchor.constraint(equalTo: self.sendButton.leadingAnchor,
                                                          constant: -AppConstants.Constraints.half),
            self.textViewBottomConstraint,
            self.textViewHeightConstraint
        ])
        self.resizeTextViewToFitText()
    }

    func setupCollectionView() {
        // MARK: - FIX!
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.delegate = self

        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.messageTextView.topAnchor)
        ])
    }

    func setupSafeAreaBackgroundView() {
        self.addSubview(self.messageToolbarView)
        self.messageToolbarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.messageToolbarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.messageToolbarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.messageToolbarView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.messageToolbarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITextViewDelegate

extension ChatView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.resizeTextViewToFitText()
    }

    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if updatedText.isEmpty {
            self.setupMessageTextViewPlaceholder()
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument,
                                                            to: textView.beginningOfDocument)
        } else if textView.layer.opacity == Constants.messageTextViewDummyOpacity
                    && !text.isEmpty {
            textView.layer.opacity = Constants.messageTextViewOpacity
            textView.text = text
        } else {
            return true
        }
        return false
    }

    private func resizeTextViewToFitText() {
        let size = CGSize(width: self.messageTextView.frame.width, height: .infinity)
        let expectedSize = self.messageTextView.sizeThatFits(size)
        self.textViewHeightConstraint.constant = max(min(expectedSize.height,
                                                         self.maxTextHeight),
                                                     self.minTextHeight)
        self.messageTextView.isScrollEnabled = expectedSize.height > self.maxTextHeight
        UIView.animate(withDuration: Constants.messageTextViewAnimationDuration) {
            self.layoutIfNeeded()
        }
    }
}

private extension ChatView {
    func heightForString(line: String) -> CGFloat {
        let textView = UITextView()
        let maxwidth = UIScreen.main.bounds.width
        textView.frame = CGRect(x:0,
                                y: 0,
                                width: maxwidth,
                                height: CGFloat(MAXFLOAT))
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.font = Constants.messageTextViewFont
        textView.text = line
        textView.isScrollEnabled = false
        textView.sizeToFit()
        return textView.frame.size.height
    }

    func setupMessageTextViewPlaceholder() {
        self.messageTextView.layer.opacity = Constants.messageTextViewDummyOpacity
        self.messageTextView.font = Constants.messageTextViewFont
        self.messageTextView.text = Constants.messageTextViewPlaceholder
    }

    func setupTapToHideKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

// MARK: - Notifications setup

private extension ChatView {
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            self.textViewBottomConstraint.constant = -(keyboardSize.height - self.safeAreaInsets.bottom)
            self.sendButtonBottomConstraint.constant = -(keyboardSize.height + AppConstants.Constraints.half - self.safeAreaInsets.bottom)
            UIView.animate(withDuration: Constants.messageTextViewAnimationDuration) {
                self.layoutIfNeeded()
                self.scrollToBottom()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.textViewBottomConstraint.constant = 0
        self.sendButtonBottomConstraint.constant = -AppConstants.Constraints.half
        UIView.animate(withDuration: Constants.messageTextViewAnimationDuration) {
            self.layoutIfNeeded()
        }
    }

    func scrollToBottom() {
        let messagesCount = self.collectionView.numberOfItems(inSection: 0)
        self.collectionView.scrollToItem(at: IndexPath(row: messagesCount-1,
                                                       section: 0),
                                         at: .bottom,
                                         animated: true)
    }
}

extension ChatView: UICollectionViewDelegate {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: self.bounds.size.width,
                                          height: 0)
        super.traitCollectionDidChange(previousTraitCollection)
    }
}
