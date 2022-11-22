//
//  SceneDelegate.swift
//  BreakingBadApp
//
//  Created by roman Khilchenko on 21.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainVc = MainViewController()
        let navigationVc = UINavigationController(rootViewController: mainVc)
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = navigationVc
        self.window = window
        window.makeKeyAndVisible()
    }
}
