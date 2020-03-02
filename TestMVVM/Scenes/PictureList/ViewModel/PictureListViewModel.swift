//
//  PictureListViewModel.swift
//  TestMVVM
//
//  Created by Davide Fin on 27/02/2020.
//  Copyright © 2020 Davide Fin. All rights reserved.
//

import Foundation

class PictureListViewModel {

    // MARK: - Closures
    
    // Through these closures, our view model will execute code while some events will occure
    // They will be set up by the view controller
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?
    
    
    // MARK: - Properties
    
    // We defined the FakeAPIServiceProtocol in the FakeAPIService.swift file.
    // We also defined a class and make it conform to that protocol.
    let apiService: FakeAPIServiceProtocol

    // This will contain info about the picture eventually selectded by the user by tapping an item on the screen
    var selectedPicture: Picture?
    
    // The collection that will contain our fetched data
    private var pictures: [Picture] = [Picture]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    // A property containing the number ot items, it will be used by the view controller to render items on the screen using a
    var numberOfItems: Int {
        return pictures.count
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    
    // MARK: - Constructor
    
    // Note: apiService has a default value in case this constructor is executed without passing parameters
    init( apiService: FakeAPIServiceProtocol = FakeAPIService()) {
        self.apiService = apiService
    }
    
    
    // MARK: - Fetching functions
    
    func fetchData() {
        self.isLoading = true
        apiService.getPopularPictures(complete: ) { [weak self] (success, pictures, error) in
            
            if let error = error {
                print ("Error: \(error.rawValue)")
            } else {
                self?.pictures = pictures
            }
            
            self?.isLoading = false
        }
    }
    
    
    // MARK: - Retieve Data
    
    func getData( at indexPath: IndexPath ) -> Picture {
        return pictures[indexPath.row]
    }
}
