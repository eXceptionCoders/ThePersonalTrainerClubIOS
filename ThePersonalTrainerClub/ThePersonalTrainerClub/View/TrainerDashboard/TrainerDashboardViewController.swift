//
//  TrainerDashboardViewController.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 11/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

class TrainerDashboardViewController: BaseTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trainerManagerVC = TrainerManagementViewController()
        let firstVC = trainerManagerVC.embedInNavigationController()
        firstVC.tabBarItem = UITabBarItem(title: "Management", image: UIImage(named: "TaskListUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:"TaskListSelected")?.withRenderingMode(.alwaysOriginal))
        firstVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        firstVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        let switchModeVC = TypeSelectionViewController()
        let secondVC = switchModeVC.embedInNavigationController()
        secondVC.tabBarItem = UITabBarItem(title: "Switch", image: UIImage(named: "SwitchUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SwitchSelected")?.withRenderingMode(.alwaysOriginal))
        secondVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        secondVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        let newClassVC = NewClassViewController()
        let thirdVC = newClassVC.embedInNavigationController()
        thirdVC.tabBarItem = UITabBarItem(title: "New Class", image: UIImage(named: "AddUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "AddSelected")?.withRenderingMode(.alwaysOriginal))
        thirdVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        thirdVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        let settingsVC = UserSettingsViewController()
        let fourth = settingsVC.embedInNavigationController()
        fourth.tabBarItem = UITabBarItem(title: "User Settings", image: UIImage(named: "SettingsUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SettingsSelected")?.withRenderingMode(.alwaysOriginal))
        fourth.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        fourth.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        let tabBarList = [firstVC, secondVC, thirdVC, fourth]
        
        viewControllers = tabBarList
    }
    

}
