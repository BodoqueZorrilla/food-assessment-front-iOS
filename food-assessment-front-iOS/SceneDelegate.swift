//
//  SceneDelegate.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let viewController = HomeViewController()
        window?.windowScene = windowScene
        var navController =  UINavigationController()
        navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
}
