//
//  ViewController.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 22.10.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.pushViewController(OnboardingViewController(), animated: true)
    }


}

