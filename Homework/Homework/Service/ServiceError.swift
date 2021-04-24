//
//  ServiceError.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation


enum ServiceError: Error {
    case networkError
    case invalidJson
    case emptyResult
    case notAuthorized
}
