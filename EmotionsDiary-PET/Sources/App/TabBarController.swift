//
//  TabBarController.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 17.11.2022.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBarController()
        setupTabBarViewControllers()
    }
    
    func setupTabBarController() {
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    func setupTabBarViewControllers() {        
        let diaryViewController = CalendarViewController()
        diaryViewController.tabBarItem = UITabBarItem(title: "Дневник", image: UIImage(systemName: "photo.on.rectangle"), tag: 0)
        
        let emotionsViewController = EmotionsViewController()
        emotionsViewController.tabBarItem = UITabBarItem(title: "Эмоции", image: UIImage(systemName: "heart.text.square.fill"), tag: 1)
        
        let mistakesViewController = MistakesViewController()
        mistakesViewController.tabBarItem = UITabBarItem(title: "Когнетивные ошибки", image: UIImage(systemName: "square.stack.fill"), tag: 2)
        
        let controllers = [diaryViewController,
                           emotionsViewController,
                           mistakesViewController]
        self.setViewControllers(controllers, animated: true)
    }
}



