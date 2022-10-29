//
//  MainTabBarController.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let advertInteractor = AdvertInteractor()
        let advertPresenter = AdvertPresenter(interactor: advertInteractor)
        let advertViewController = AdvertViewController(presenter: advertPresenter)
        advertViewController.title = "Advert"
        let advertNavigationController = UINavigationController(rootViewController: advertViewController)
        
        let cameraViewController = CameraViewController()
        cameraViewController.title = "Camera"
        let cameraNavigationController = UINavigationController(rootViewController: cameraViewController)
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        setViewControllers([advertNavigationController,
                            cameraNavigationController,
                            profileNavigationController], animated: true)
    }
}
