//
//  UserModel.swift
//  SampleAPIApp
//
//  Created by Jyoti Bhagwat on 02/05/24.
//

import Foundation
import UIKit

struct UserModel : Codable{
    let data : [userList]?
    let status: Status?
    enum CodingKeys: String, CodingKey {
        case status,data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent([userList].self, forKey: .data)
        self.status = try container.decodeIfPresent(Status.self, forKey: .status)
    }
    
}

struct userList: Codable {
    let id: Int?
    let title : String?
    let body : String?
    
    init(id: Int?, title: String?, body: String?) {
        self.id = id
        self.title = title
        self.body = body
    }
}

// MARK: - Status
struct Status: Codable {
    let code: Int
    let message: String
}
