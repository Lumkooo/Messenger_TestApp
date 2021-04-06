//
//  StartView.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import UIKit

protocol IStartView: AnyObject {
    var loginButtonTapped: (()-> Void)? { get set }

    func viewDidAppear()
}

final class StartView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let imageHeightMultiplier: CGFloat = 0.4
        static let buttonHeightMultiplier: CGFloat = 0.1

//        Заливка: FFFFFF

        static let screenColor = UIColor(rgb: 0xFFFFFF)

//        Изображение:
//            Тень:
//                Цвет: 000000
//                Прозрачность: 0.5
//                Отступ: 0,2
//                Радиус: 4

        static let imageShadowColor: CGColor = UIColor(rgb: 0x000000).cgColor
        static let imageShadowOpacity: Float = 0.5
        static let imageShadowOffset: CGSize = CGSize(width: 0, height: 2)
        static let imageShadowRadius: CGFloat = 4

//        Кнопка:
//            Заливка: CF1F28
//            Тень:
//                Цвет: E4222D
//                Прозрачность: 0.5
//                Отступ: 0,2
//                Радиус: 9
//            Текст:
//                Шрифт: Системный жирный 18
//                Цвет: FFFFFF
//            Скругление: Полное по высоте

        static let loginButtonColor = UIColor(rgb: 0xCF1F28)
        static let loginButtonShadowColor: CGColor = UIColor(rgb: 0xE4222D).cgColor
        static let loginButtonShadowOpacity: Float = 0.5
        static let loginButtonShadowOffset: CGSize = CGSize(width: 0, height: 2)
        static let loginButtonShadowRadius: CGFloat = 9
        static let loginButtonTextFont: UIFont = .systemFont(ofSize: 18, weight: .bold)
        static let loginButtonTextColor = UIColor(rgb: 0xFFFFFF)
        static let loginButtonAnimationDuration: Double = 0.5


        static let loadingViewAlpha: CGFloat = 0.4
        static let loadingViewAnimationDuration: Double = 0.3
        static let loadingViewDuration: Double = 1
    }

    // MARK: - Views

    private lazy var startImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = AppConstants.Images.startImage
        myImageView.contentMode = .scaleAspectFit
        myImageView.layer.shadowColor = Constants.imageShadowColor
        myImageView.layer.shadowOpacity = Constants.imageShadowOpacity
        myImageView.layer.shadowOffset = Constants.imageShadowOffset
        myImageView.layer.shadowRadius = Constants.imageShadowRadius
        return myImageView
    }()

    private lazy var loginButton: UIButton = {
        let myButton = UIButton()
        myButton.backgroundColor = Constants.loginButtonColor
        myButton.layer.shadowColor = Constants.loginButtonShadowColor
        myButton.layer.shadowOpacity = Constants.loginButtonShadowOpacity
        myButton.layer.shadowOffset = Constants.loginButtonShadowOffset
        myButton.layer.shadowRadius = Constants.loginButtonShadowRadius
        myButton.titleLabel?.font = Constants.loginButtonTextFont
        myButton.titleLabel?.textColor = Constants.loginButtonTextColor
        myButton.setTitle("Войти", for: .normal)
        myButton.alpha = 0
        myButton.addTarget(self,
                           action: #selector(self.loginButtonTapped(gesture:)),
                           for: .touchUpInside)
        return myButton
    }()

    private lazy var loadingView: UIView = {
        let myView = UIView()
        myView.backgroundColor = UIColor.white.withAlphaComponent(Constants.loadingViewAlpha)
        return myView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let myActivityIndicatoyView = UIActivityIndicatorView()
        myActivityIndicatoyView.hidesWhenStopped = true
        myActivityIndicatoyView.startAnimating()
        return myActivityIndicatoyView
    }()

    // MARK: - Proeprties

    var loginButtonTapped: (()-> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.backgroundColor = Constants.screenColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Обработка нажатия на кнопки

    @objc private func loginButtonTapped(gesture: UIGestureRecognizer) {
        self.loginButton.isEnabled = false
        self.setupLoadingView()
        self.loadingView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        UIView.animate(withDuration: Constants.loadingViewAnimationDuration) {
            self.loadingView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.loadingViewDuration) {
            self.loginButton.isEnabled = true
            self.loadingView.removeFromSuperview()
            self.loginButtonTapped?()
        }
    }

    // MARK: - layouSubviews

    override func layoutSubviews() {
        self.loginButton.layer.cornerRadius = self.loginButton.frame.height/2
    }
}

// MARK: - IStartView

extension StartView: IStartView {
    func viewDidAppear() {
        UIView.animate(withDuration: Constants.loginButtonAnimationDuration) {
            self.loginButton.transform = CGAffineTransform(
                translationX: 0,
                y: -(self.loginButton.frame.height+AppConstants.Constraints.normal))
            self.loginButton.alpha = 1
        }
    }
}

// MARK: - UISetup

private extension StartView {
    func setupElements() {
        self.setupStartImageView()
        self.setupLoginButton()
    }

    func setupStartImageView() {
        self.addSubview(self.startImageView)
        self.startImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.startImageView.centerYAnchor.constraint(
                equalTo: self.centerYAnchor,
                constant: -AppConstants.Constraints.fourTimes),
            self.startImageView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: AppConstants.Constraints.normal),
            self.startImageView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -AppConstants.Constraints.normal),
            self.startImageView.heightAnchor.constraint(
                equalTo: self.startImageView.widthAnchor,
                multiplier: Constants.imageHeightMultiplier)
        ])
    }

    func setupLoginButton() {
        self.addSubview(self.loginButton)
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.loginButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: AppConstants.Constraints.normal),
            self.loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -AppConstants.Constraints.normal),
            self.loginButton.heightAnchor.constraint(equalTo: self.heightAnchor,
                                                     multiplier: Constants.buttonHeightMultiplier)
        ])
    }

    func setupLoadingView() {
        self.addSubview(self.loadingView)
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.topAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.setupActivityIndicatorView()
    }

    func setupActivityIndicatorView() {
        self.loadingView.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor)
        ])
    }
}
