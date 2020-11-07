//
//  SceneDelegate.swift
//  APOD
//
//  Created by Gil Rodarte on 06/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let dateListViewModel = DateListViewModel()
        let dateListViewController = DateListViewController(viewModel: dateListViewModel)
        window?.rootViewController = UINavigationController(rootViewController: dateListViewController)
    }

}

