//
//  AdvertViewController.swift
//  Ceksat
//
//  Created by Pazarama iOS Bootcamp on 29.10.2022.
//

import UIKit

final class AdvertViewController: UIViewController {
    // MARK: - Properties
    var presenter: AdvertPresenter
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    // MARK: - Init
    init(presenter: AdvertPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.fetchProducts()
        presenter.view = self
    }
}

// MARK: - AdvertPresenterDelegate
extension AdvertViewController: AdvertPresenterDelegate {
    func didErrorOccurred(_ error: Error) {
        print(error.localizedDescription)
    }
    
    func didFetchProducts() {
        tableView.reloadData()
    }
}
