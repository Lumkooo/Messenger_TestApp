//
//  AppDelegate.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Constants

    private enum Constants {
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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.backgroundColor = Constants.navigationBarBackgroundColor
        navigationBarAppearace.layer.shadowColor = Constants.navigationBarShadowColor
        // Если ставить largeTitles, то зона с временем и системными иконками наверху - другого цвета
        // Исправить это не смог
//        navigationBarAppearace.prefersLargeTitles = true
        navigationBarAppearace.layer.shadowOpacity = Constants.navigationBarShadowOpacity
        navigationBarAppearace.layer.shadowOffset = Constants.navigationBarShadowOffset
        navigationBarAppearace.layer.shadowRadius = Constants.navigationBarShadowRadius
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Messenger_TestApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

