//
//  AppDelegate.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 04/02/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let splitViewController = UISplitViewController()
        splitViewController.preferredDisplayMode = .allVisible

        let itemsListVC = ItemsListViewController()
        splitViewController.delegate = itemsListVC

        let itemsListNavigationVC = UINavigationController(rootViewController: itemsListVC)
        let itemVC = ItemViewController()

        splitViewController.viewControllers = [itemsListNavigationVC, itemVC]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()

        return true
    }
}

