//
//  AlamoFireWrapper.swift
//  FRT
//
//  Created by Jyoti Bhagwat on 02/05/24.
//

import Foundation
import Alamofire
import RappleProgressHUD
enum ApiMethod {
    case get, post, put,multipart,delete
}

class AlamoFireWrapper: NSObject {
    class var sharedInstance: AlamoFireWrapper{
        struct Singleton{
            static let instance = AlamoFireWrapper()
        }
        return Singleton.instance
    }
    
    //var alamoFireManager : SessionManager?
    func networkRequest<T: Decodable>(urlString: String,param: [String:Any],httpMethod:ApiMethod, completionBlock: @escaping (T?, AFDataResponse<Any>?) -> ()){
        let url : String = urlString
        
        print(url)
        
        var httpMethodStr:HTTPMethod?
        
        if httpMethod == .post{
            httpMethodStr = .post
        }else if httpMethod == .get{
            httpMethodStr = .get
        }else if httpMethod == .put{
            httpMethodStr = .put
        }else if httpMethod == .delete{
            httpMethodStr = .delete
        }
        let configuration = URLSessionConfiguration.default
       configuration.timeoutIntervalForRequest = 10
       configuration.timeoutIntervalForResource = 10
        
        let manager = AF.session
        
        manager.configuration.timeoutIntervalForRequest = 120
        RappleActivityIndicatorView.startAnimating()
        AF.request(url, method: httpMethodStr ?? .get , parameters: param, headers: nil).responseJSON {
            response in
            RappleActivityIndicatorView.stopAnimation(completionIndicator: .failed, completionLabel: "Unable to retrieve data", completionTimeout: 1.5)
            switch response.result {
            case .success(let value):
                if let JSON = value as? [Any] {
                    print(response.result)
                    
                    do {
                        let jsonData =  try JSONSerialization.data(withJSONObject: JSON, options: JSONSerialization.WritingOptions.prettyPrinted)
                        
                        guard let data = jsonData as? Data else { return }
                        let dataReceived = try JSONDecoder().decode(T.self, from: data)
                        
                        completionBlock(dataReceived,response)
                    } catch let jsonErr {
                        print("Failed to serialize json:", jsonErr, jsonErr.localizedDescription)
                        completionBlock(nil,response)
                    }
                    
                }
            case .failure(let error):
                print("Failed to serialize json:", error, error.localizedDescription)
                completionBlock( nil,response)
                break
                
                
            }
        }
    }
}
