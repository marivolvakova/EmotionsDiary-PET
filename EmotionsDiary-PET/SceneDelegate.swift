//
//  SceneDelegate.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 29.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard (scene is UIWindowScene) else { return }
        let tabBarController = UITabBarController()
        let diaryViewController = CalendarViewController()
        diaryViewController.tabBarItem = UITabBarItem(title: "Дневник", image: UIImage(systemName: "photo.on.rectangle"), tag: 0)
        let emotionsViewController = EmotionsViewController()
        emotionsViewController.tabBarItem = UITabBarItem(title: "Эмоции", image: UIImage(systemName: "heart.text.square.fill"), tag: 1)
        let mistakesViewController = MistakesViewController()
        mistakesViewController.tabBarItem = UITabBarItem(title: "Когнетивные ошибки", image: UIImage(systemName: "square.stack.fill"), tag: 2)
        let controllers = [
            diaryViewController,
            emotionsViewController,
            mistakesViewController
            ]
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

