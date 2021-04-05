//
//  AppConstants.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import UIKit

enum AppConstants {

    // MARK: - Images

    enum Images {
        static let startImage = UIImage(named: "StartScreen")
        static let iconSend = UIImage(named: "iconSend")
        static let iconDelete = UIImage(named: "iconDelete")
    }

    // MARK: - Constraints

    enum Constraints {
        static let normal: CGFloat = 16.0
        static let half: CGFloat = 8.0
        static let quarter: CGFloat = 4.0
        static let twice: CGFloat = 32.0
        static let fourTimes: CGFloat = 64.0
    }
}
