//
//  CafeSearchService.swift
//  Homework
//
//  Created by 허원재 on 2021/04/24.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import SwiftyJSON


class CafeSearchService {
    static func cafeSearch(_ requestModel:SearchRequestModel) -> Observable<Result<[CafeSearchResultModel],ServiceError>> {
        let headers: HTTPHeaders = ["Authorization": "KakaoAK "+Constants.daumRestAPIKey]
        return RxAlamofire.request(.get, ServiceAPI.cafe.urlString, parameters: requestModel.parameters, headers: headers).responseData()
            .debug()
            .map { response, data -> Result<[CafeSearchResultModel],ServiceError> in
                let dic = JSON(json)
                print(dic)
                guard 200..<300 ~= response.statusCode else {
                    return .failure(ServiceError.notAuthorized)
                }
                do {
                    let result = try JSONDecoder().decode(CafeSearchResult.self, from: data)
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


struct CafeSearchResult:Codable {
    let documents:[CafeSearchResultModel]
    let meta:MetaModel
    
    private enum CodingKeys:String, CodingKey {
        case documents
        case meta
    }
}

