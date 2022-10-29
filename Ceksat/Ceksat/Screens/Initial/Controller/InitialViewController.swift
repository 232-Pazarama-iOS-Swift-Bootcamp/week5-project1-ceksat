//
//  InitialViewController.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 22.10.2022.
//

import UIKit

final class InitialViewController: UIViewController {
    
    private let viewModel = InitialViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.fetchProducts()
    }
}

// MARK: - InitialViewModelDelegate
extension InitialViewController: InitialViewModelDelegate {
    func didErrorOccurred(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchProducts() {
        navigationController?.pushViewController(OnboardingViewController(), animated: true)
    }
}
