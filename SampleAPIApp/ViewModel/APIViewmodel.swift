//
//  APIViewmodel.swift
//  SampleAPIApp
//
//  Created by Jyoti Bhagwat on 02/05/24.
//

import Foundation
import UIKit
import Alamofire

class APIViewmodel {
    
    func callDataViewModel<T: Decodable>(urlStr:String,method:ApiMethod,paramDict:[String:Any], onSuccess: @escaping(_ reponseData:T?,AFDataResponse<Any>?) -> Void, onFailure: @escaping(Error) -> Void){
        switch method {
        case .get, .post ,.put, .delete, .multipart:
            AlamoFireWrapper.sharedInstance.networkRequest(urlString: urlStr, param: paramDict, httpMethod: method) { (RESPONSE_DATA:T?, URL_RESPONSE) in
                onSuccess(RESPONSE_DATA, URL_RESPONSE)
            }
            
       
        }
    }
    
}
