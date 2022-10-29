//
//  AdvertRouter.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import UIKit

final class AdvertRouter {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func goToDetailFor(_ product: ProductEntity) {
        let viewController = ProductDetailViewController(product: product)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
