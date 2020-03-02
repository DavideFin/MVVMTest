//
//  ViewController.swift
//  TestMVVM
//
//  Created by Davide Fin on 27/02/2020.
//  Copyright © 2020 Davide Fin. All rights reserved.
//

import UIKit

class PictureListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var adapter : PictureListAdapter!
    
    lazy var viewModel: PictureListViewModel = {
        return PictureListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter = PictureListAdapter (delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter
        
        setupUI()
        initViewModel()
    }
    
    func setupUI() {
        self.navigationItem.title = "Popular"
    }
    
    func initViewModel() {
        
        // Setup for reloadTableViewClosure
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Setup for updateLoadingStatusClosure
        viewModel.updateLoadingStatusClosure = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.fetchData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "goToDetails":
            let destination = segue.destination as! PictureDetailViewController
            destination.picture = viewModel.selectedPicture
        default:
            break
        }
    }
}

extension PictureListViewController : PictureListProtocol {
    func itemSelected(at: IndexPath) {
        viewModel.selectedPicture = self.viewModel.getData(at: at)
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    func getData(at: IndexPath)->Picture {
        return self.viewModel.getData(at: at)
    }
    
    func retrieveNumberOfSections()->Int {
        return 1
    }
    
    func retrieveNumberOfItems()->Int {
        return self.viewModel.numberOfItems
    }
}
