//
//  NavigationControllerAssembly.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import UIKit

enum NavigationControllerAssembly {
    static func createNavigationController(rootViewController: UIViewController) -> UINavigationController {

        // MARK: - Constants

        enum Constants {
    //        Бар навигации:
    //            Стандартные настройки
    //            Тень:
    //                Цвет: 000000
    //                Прозрачность: 0.38
    //                Отступ: 0,2
    //                Радиус: 7

            static let navigationBarShadowColor = UIColor(rgb: 0x000000).cgColor
            static let navigationBarShadowOpacity: Float = 0.38
            static let navigationBarShadowOffset: CGSize = CGSize(width: 0, height: 2)
            static let navigationBarShadowRadius: CGFloat = 7
            static let navigationBarBackgroundColor = UIColor(rgb: 0xFFFFFF)
        }

        let navigationController = UINavigationController(rootViewController: rootViewController)
//        navigationController.navigationBar.prefersLargeTitles = true

        navigationController.navigationBar.layer.masksToBounds = false
        navigationController.navigationBar.backgroundColor = Constants.navigationBarBackgroundColor
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: Constants.navigationBarBackgroundColor]
        navigationController.navigationBar.layer.shadowColor = Constants.navigationBarShadowColor
        navigationController.navigationBar.layer.shadowOpacity = Constants.navigationBarShadowOpacity
        navigationController.navigationBar.layer.shadowOffset = Constants.navigationBarShadowOffset
        navigationController.navigationBar.layer.shadowRadius = Constants.navigationBarShadowRadius
        return navigationController
    }
}
