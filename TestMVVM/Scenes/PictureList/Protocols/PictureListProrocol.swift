//
//  PictureListProrocol.swift
//  TestMVVM
//
//  Created by Davide Fin on 27/02/2020.
//  Copyright © 2020 Davide Fin. All rights reserved.
//

import Foundation

protocol PictureListProtocol {
    func getData(at: IndexPath)->Picture
    func itemSelected(at: IndexPath)
    func retrieveNumberOfSections()->Int
    func retrieveNumberOfItems()->Int
}
