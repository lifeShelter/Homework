//
//  BlogSearchService.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import SwiftyJSON


class BlogSearchService {
    static func blogSearch(_ requestModel:SearchRequestModel) -> Observable<Result<[BlogSearchResultModel],ServiceError>> {
        let headers: HTTPHeaders = ["Authorization": "KakaoAK "+Constants.daumRestAPIKey]
        return RxAlamofire.request(.get, ServiceAPI.blog.urlString, parameters: requestModel.parameters, headers: headers).responseData()
            .map { response, data -> Result<[BlogSearchResultModel],ServiceError> in
                guard 200..<300 ~= response.statusCode else {
                    return .failure(ServiceError.notAuthorized)
                }
                do {
                    let result = try JSONDecoder().decode(BlogSearchResult.self, from: data)
                    if result.documents.count <= 0 {
                        return .failure(ServiceError.emptyResult)
                    } else {
                        return .success(result.documents)
                    }
                } catch {
                    return .failure(ServiceError.invalidJson)
                }
            }.catchAndReturn(.failure(ServiceError.networkError))
    }
}


struct BlogSearchResult:Codable {
    let documents:[BlogSearchResultModel]
    let meta:MetaModel
    
    private enum CodingKeys:String, CodingKey {
        case documents
        case meta
    }
}
