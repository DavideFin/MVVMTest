//
//  APIService.swift
//  TestMVVM
//
//  Created by Davide Fin on 27/02/2020.
//  Copyright © 2020 Davide Fin. All rights reserved.
//

import Foundation

// Define a protocol containing the signature of a function to fetch data
protocol FakeAPIServiceProtocol: AnyObject {
    func getPopularPictures( complete: @escaping ( _ success: Bool, _ photos: [Picture], _ error: FakeAPIError? )->() )
}

// Declare the FakeAPIService class an make it conform to the FakeAPIServiceProtocol.
// Doing this we can easily assign this protocol in the PictureListViewController
class FakeAPIService: FakeAPIServiceProtocol {
    
    func getPopularPictures( complete: @escaping ( _ success: Bool, _ pictures: [Picture], _ error: FakeAPIError? )->() ) {
        
        // Use a dispatch queue that schedules tasks for concurrent execution.
        DispatchQueue.global().async {
            
            // Initialize the json decoder
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            // Simulate latency while fetching data
            sleep(4)
            
            // Load data from a local file containing json
            let path = Bundle.main.path(forResource: "fakecontents", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                        
            // Decode data
            let pictures = try! decoder.decode(Pictures.self, from: data)
            complete( true, pictures.pictures, nil )
        }
    }
}
