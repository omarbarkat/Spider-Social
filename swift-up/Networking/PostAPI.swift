//
//  PostAPI.swift
//  swift-up
//
//  Created by Omar barkat on 14/11/2023.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

//import AsyncAlgorithms



class PostAPI {
    var tags: String = ""
    static let appID = "654a735b9848f4fa9ab41b7c"
   static let headers : HTTPHeaders = [
        "app-id" : appID
    ]
    static let baseUrl = "https://dummyapi.io/data/v1"

    static  func getAllPosts (page : Int, tags : String? ,CompletionHandler : @escaping ([Post] ,Int)->() ) {
     
        var url = baseUrl + "/post"
        if let mytags = tags {
             url = "\(baseUrl)/tag/\(mytags)/post"
        }
        let params = [
            "page" : "\(page)" ,
            "limit" : "5"
        ]
        AF.request(url,parameters: params, encoder: URLEncodedFormParameterEncoder.default ,   headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let dataa = jsonData["data"]
            let total = jsonData["total"].intValue
          //  let tag = dataa[3]["tags"]
            let decodable = JSONDecoder()
            do {
              let posts = try decodable.decode([Post].self, from: dataa.rawData())
                CompletionHandler(posts,total)
              //  print(tag)
            } catch let error{
                print(error)
            }
        
        }
    }
    static  func GetAllTags (CompletionHandler: @escaping ([String])->()){
        let url = baseUrl + "/tag"
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            var data = jsonData["data"]
            
         //   var mydata = data
           // mydata.removeFirst().null
            //let medata = mydata.lazy.
          //  print(mydata)
        //    let data: [JSON?] = jsonData["data"].rawValue as! [JSON?]
         //   let withNoNils = data.compacted()
            
          //  let data = jsonData["data"]
           // var nonNilElements = data.flatMap { $0 }
          //  nonNilElements = nonNilElements.filter { $0 != nil }
          //  print(nonNilElements)
       //     let data = jsonData["data"]
       //     print(data.compact())
            // Array(withNoNils) == [10, 30, 2, 3, 5]
            
       //     data.map {($1 as? String) ?? ""}
            
            
            do {
                let decodable = JSONDecoder()
             //   let xTag = try decodable.decode([String].self, from: mydata.rawData())
                
               // print("tagzzzzzzz: ", xTag)
            } catch {
                print("JSONSerialization: ", error)
            }
            
//           do {
////               let tags = try decodable.decode([String].self, from: data[].rawData())
////                print(tags)
////                CompletionHandler(tags)
//            } catch let error{
////                print(error)
//            }
//           // print(data)

        }
    }
    static func getUserProfile ( id : String , CompletionHandler :@escaping (User) ->() ) {
        let url = baseUrl + "/user/\(id)"
    
        AF.request(url, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
        let decodable = JSONDecoder()
         do {
             let profileInfo = try decodable.decode(User.self, from: jsonData.rawData())
            CompletionHandler(profileInfo)
             
            } catch let error{
              print(error)
            }
        }
    }
    static   func getPostDetails (post:Post,CompletionHandler : @escaping ([Comment])->()) {
        let  url = baseUrl + "/post/\(post.id)/comment"
           AF.request(url, headers: headers).responseJSON { response in
               print(response)
               let jsonData = JSON(response.value)
               let dataa = jsonData["data"]
               print(jsonData)
             let decodable = JSONDecoder()
             do {
                let postDetails = try decodable.decode([Comment].self, from: dataa.rawData())
                 CompletionHandler(postDetails)
               } catch let error{
                   print(error)
               }
           }
       }
    static func registerUser ( firstName : String , lastName : String , email: String , CompletionHandler :@escaping (User? , String?) ->() ) {
        let url = baseUrl + "/user/create"
        let params = [
            "lastName": lastName,
            "firstName":firstName,
            "email": email
        ]
        
        AF.request(url,method: .post, parameters: params,encoder: JSONParameterEncoder.default ,  headers: headers).validate() .responseJSON { response in
            switch response.result {
                   case .success:
                       print("Validation Successful")
                let jsonData = JSON(response.value)
                print(jsonData)
            let decodable = JSONDecoder()
             do {
                 let user = try decodable.decode(User.self, from: jsonData.rawData())
                CompletionHandler(user,nil)
                 
                } catch let error{
                  print(error)
                }
                   case let .failure(error):
               let jsondata = JSON(response.data)
                print(jsondata)
                let data = jsondata["data"]
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMsg = firstNameError + " " + lastNameError + " " + emailError
                CompletionHandler(nil ,errorMsg )
                print(errorMsg)
                   }
       
        }
    }
  
    static func signInUser ( firstName : String , lastName : String ,  CompletionHandler :@escaping (User? , String?) ->() ) {
        let url = baseUrl + "/user"
        let params = [
            "created":  "1"
        ]
        
        AF.request(url,method: .get, parameters: params,encoder: URLEncodedFormParameterEncoder.default ,  headers: headers).validate() .responseJSON { response in
            switch response.result {
                   case .success:
                       print("Validation Successful")
                let jsonData = JSON(response.value)
                let data = jsonData["data"]

                print(data)
            let decodable = JSONDecoder()
                
             do {
                 let users = try decodable.decode([User].self, from: data.rawData())
                 
                 var foundUser : User?
                 for user in users {
                     if user.firstName == firstName && user.lastName == lastName {
                         foundUser = user
                         break
                     }
                 }
                 if let user = foundUser {
                     CompletionHandler(user , nil)

                 }else {
                     CompletionHandler(nil , "The FirstName Of The LastName Is Not Match Any User")
                 }
                 print(users)
                } catch let error{
                  print(error)
                }
                   case let .failure(error):
               let jsondata = JSON(response.data)
                print(jsondata)
                let data = jsondata["data"]
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMsg = firstNameError + " " + lastNameError + " " + emailError
                CompletionHandler(nil ,errorMsg )
                print(errorMsg)
                   }
       
        }
    }
    static func createComment ( message : String , owner : String , post: String , CompletionHandler :@escaping () ->() ) {
        let url = baseUrl + "/comment/create"
        let params = [
            "message": message,
            "owner": owner,
            "post": post
        ]
        
        AF.request(url,method: .post, parameters: params,encoder: JSONParameterEncoder.default ,  headers: headers).validate() .responseJSON { response in
            switch response.result {
                   case .success:
                CompletionHandler()
                   case let .failure(error):
                print(error)
                   }
       
        }
    }

    static func createPost (likes: Int , tags: String, text : String , owner : String , image: String , CompletionHandler :@escaping (Post? , String?) ->() ) {
        let url = baseUrl + "/post/create"
        let params : [String : String] = [
            "likes": "\(likes)",
            "tags": tags,
            "text": text ,
           "owner" : owner ,
           "image" : image
        ]
        
        AF.request(url,method: .post, parameters: params,encoder: JSONParameterEncoder.default  ,  headers: headers).validate() .responseJSON { response in
            switch response.result {
                   case .success:
                       print("Validation Successful")
                let jsonData = JSON(response.value)
                print(jsonData)
            let decodable = JSONDecoder()
             do {
                 let post = try decodable.decode(Post.self, from: jsonData.rawData())
                CompletionHandler(post,nil)
                 print(post)
                 
                } catch let error{
                  print(error)
                }
                   case let .failure(error):
               let jsondata = JSON(response.data)
                print(jsondata)
                print(error)
               // let data = jsondata["data"]
              //  let emailError = data["email"].stringValue
                //let firstNameError = data["firstName"].stringValue
          //      let lastNameError = data["lastName"].stringValue
            //    let errorMsg = firstNameError + " " + lastNameError + " " + emailError
              //  CompletionHandler(nil ,errorMsg )
               // print(errorMsg)
                   }
       
        }
    }
    static func UpdateUserIfon ( firstName : String , phone : String , ImageURL: String ,userId: String , CompletionHandler :@escaping (User? , String?) ->() ) {
        let url = baseUrl + "/user/\(userId)"
        let params = [
            "firstName":firstName,
            "phone" : phone ,
            "picture": ImageURL
        ]
        
        AF.request(url,method: .put, parameters: params,encoder: JSONParameterEncoder.default ,  headers: headers).validate() .responseJSON { response in
            switch response.result {
                   case .success:
                       print("Validation Successful")
                let jsonData = JSON(response.value)
                print(jsonData)
            let decodable = JSONDecoder()
             do {
                 let user = try decodable.decode(User.self, from: jsonData.rawData())
                CompletionHandler(user,nil)
                 
                } catch let error{
                  print(error)
                }
                   case let .failure(error):
               let jsondata = JSON(response.data)
                print(jsondata)
                let data = jsondata["data"]
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                let errorMsg = firstNameError + " " + lastNameError + " " + emailError
                CompletionHandler(nil ,errorMsg )
                print(errorMsg)
                   }
       
        }
    }

}


