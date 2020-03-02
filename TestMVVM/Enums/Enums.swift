//
//  Enums.swift
//  TestMVVM
//
//  Created by Davide Fin on 27/02/2020.
//  Copyright © 2020 Davide Fin. All rights reserved.
//

import Foundation

enum FakeAPIError: String, Error {
    case serverUnavailable = "Server is unavailable"
    case permissionDenied = "Permission denied"
}
