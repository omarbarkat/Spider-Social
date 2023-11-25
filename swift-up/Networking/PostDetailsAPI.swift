//
//  PostDetailsAPI.swift
//  swift-up
//
//  Created by Omar barkat on 14/11/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostDetailsAPI {
 static   func getPostDetails (post:Post,CompletionHandler : @escaping ([Comment])->()) {
     let  url = "https://dummyapi.io/data/v1/post/\(post.id)/comment"
        let appID = "654a735b9848f4fa9ab41b7c"
        let headers : HTTPHeaders = [
            "app-id" : appID
        ]

        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let dataa = jsonData["data"]
          let decodable = JSONDecoder()
          do {
             let postDetails = try decodable.decode([Comment].self, from: dataa.rawData())
              CompletionHandler(postDetails)
            } catch let error{
                print(error)
            }
        }
    }
}
