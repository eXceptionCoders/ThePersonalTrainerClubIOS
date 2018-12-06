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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (UserSettings.user?.coach ?? false) && UserSettings.showCoachView {
            initTrainerView()
        } else {
            initClientView()
        }
    }
    
    func initTrainerView() {
        let userManagerVC = TrainerManagementViewController()
        let userManagerNC = userManagerVC.embedInNavigationController()
        userManagerNC.tabBarItem = UITabBarItem(title: NSLocalizedString("trainer_management_title", comment: ""), image: UIImage(named: "TaskListUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:"TaskListSelected")?.withRenderingMode(.alwaysOriginal))
        userManagerNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        userManagerNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        let switchModeVC = TypeSelectionViewController()
        let switchModeNC = switchModeVC.embedInNavigationController()
        switchModeNC.tabBarItem = UITabBarItem(title: "Switch", image: UIImage(named: "SwitchUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SwitchSelected")?.withRenderingMode(.alwaysOriginal))
        switchModeNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        switchModeNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        let newClassVC = NewClassViewController()
        let newClassNC = newClassVC.embedInNavigationController()
        newClassNC.tabBarItem = UITabBarItem(title: "New Class", image: UIImage(named: "AddUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "AddSelected")?.withRenderingMode(.alwaysOriginal))
        newClassNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        newClassNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        let settingsVC = UserSettingsViewController()
        let settingsNC = settingsVC.embedInNavigationController()
        settingsNC.tabBarItem = UITabBarItem(title: "User Settings", image: UIImage(named: "SettingsUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SettingsSelected")?.withRenderingMode(.alwaysOriginal))
        settingsNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        settingsNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        let tabBarList = [userManagerNC, switchModeNC, newClassNC, settingsNC]
        
        viewControllers = tabBarList
    }
    
    func initClientView() {
        var tabBarList: [UIViewController] = []
        
        let userManagerVC = TrainerManagementViewController()
        let userManagerNC = userManagerVC.embedInNavigationController()
        userManagerNC.tabBarItem = UITabBarItem(title: NSLocalizedString("trainer_management_title", comment: ""), image: UIImage(named: "TaskListUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named:"TaskListSelected")?.withRenderingMode(.alwaysOriginal))
        userManagerNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        userManagerNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        tabBarList.append(userManagerNC)
        
        if UserSettings.user?.coach ?? false {
            let switchModeVC = TypeSelectionViewController()
            let switchModeNC = switchModeVC.embedInNavigationController()
            switchModeNC.tabBarItem = UITabBarItem(title: "Switch", image: UIImage(named: "SwitchUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SwitchSelected")?.withRenderingMode(.alwaysOriginal))
            switchModeNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
            switchModeNC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
            
            tabBarList.append(switchModeNC)
        }
        
        let settingsVC = UserSettingsViewController()
        let settingsNV = settingsVC.embedInNavigationController()
        settingsNV.tabBarItem = UITabBarItem(title: "User Settings", image: UIImage(named: "SettingsUnselected")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "SettingsSelected")?.withRenderingMode(.alwaysOriginal))
        settingsNV.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.customDark], for: .normal)
        settingsNV.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        tabBarList.append(settingsNV)
        
        viewControllers = tabBarList
    }
}
