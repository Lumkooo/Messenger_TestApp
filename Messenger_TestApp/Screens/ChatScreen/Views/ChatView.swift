//
//  ChatView.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatView: AnyObject {
    func showMessages(_ messages: [Message])
}

final class ChatView: UIView {

    // MARK: - Constants

    private enum Constants {

        static let messageTextViewAnimationDuration: Double = 0.3
        static let messageTextViewPlaceholder = "Введите сообщение..."
//        Область ввода сообщения:
//            Заливка: E7E7E7
//            Скругление: 5
//            Текст:
//                Цвет: 000000
//                Шрифт: Системный 17
//                Заглушка:
//                    Цвет: 000000
//                    Прозрачность: 0.3
//                    Шрифт: Системный жирный 17

        static let messageTextViewBackgroundColor = UIColor(rgb: 0xE7E7E7)
        static let messageTextViewCornerRadius: CGFloat = 5
        static let messageTextViewTextColor = UIColor(rgb: 0x000000)
        static let messageTextViewOpacity: Float = 1
        static let messageTextViewFont = UIFont.systemFont(ofSize: 17)

        static let messageTextViewDummyOpacity: Float = 0.3
        static let messageTextViewDummyFont = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    // MARK: - Views

    private lazy var collectionView: UICollectionView = {
        let myCollectionView:UICollectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: UICollectionViewFlowLayout.init())
        myCollectionView.register(ChatViewCollectionViewCell.self,
                                  forCellWithReuseIdentifier: ChatViewCollectionViewCell.reuseIdentifier)
        myCollectionView.backgroundColor = .systemBackground
        return myCollectionView
    }()

    private lazy var messageTextView: UITextView = {
        let myTextView = UITextView()
        myTextView.delegate = self
        myTextView.text = Constants.messageTextViewPlaceholder
        myTextView.backgroundColor = .systemGroupedBackground
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
        myButton.setImage(AppConstants.Images.iconSend, for: .normal)
        return myButton
    }()

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

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.setupNotifications()
        self.setupTapToHideKeyboard()
        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Обработка нажатия на кнопку

    @objc private func sendButtonTapped(gesture: UIGestureRecognizer) {
        guard let text = self.messageTextView.text else {
            return
        }
        print(text)
        self.setupMessageTextViewPlaceholder()
        self.resizeTextViewToFitText()
        self.dismissKeyboard()
    }
}

// MARK: - IChatView

extension ChatView: IChatView {
    func showMessages(_ messages: [Message]) {
        self.collectionViewDataSource.setData(messages: messages)
        self.collectionView.reloadData()
    }
}

// MARK: - UISetup

private extension ChatView {
    func setupElements() {
        self.setupSendButton()
        self.setupMessageTextView()
        self.setupCollectionView()
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
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .gray

        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.contentInsetAdjustmentBehavior = .always
        self.collectionView.contentInset = UIEdgeInsets(top: 10,
                                                        left: 10,
                                                        bottom: 10,
                                                        right: 10)

        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.messageTextView.topAnchor)
        ])

        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
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
            self.textViewBottomConstraint.constant = -keyboardSize.height
            self.sendButtonBottomConstraint.constant = -(keyboardSize.height+AppConstants.Constraints.half)
            UIView.animate(withDuration: Constants.messageTextViewAnimationDuration) {
                self.layoutIfNeeded()
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
}

extension ChatView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 50 // Approximate height of cell
        let referenceWidth: CGFloat = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
}
