//
//  APIManager.swift
//  MusicVideo
//
//  Created by ADA on 14/05/16.
//  Copyright © 2016 Samaclip. All rights reserved.
//

import Foundation

class APIManager{
    func loadData(urlString:String, completion:(result:String)-> Void){
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        //let session = NSURLSession.sharedSession()
        let url = NSURL(string:urlString)!
        
        let task = session.dataTaskWithURL(url){
            (data, respose, error)-> Void in
            
            if error != nil{
                dispatch_async(dispatch_get_main_queue()){
                    completion(result: (error!.localizedDescription))
                }
            }
            else{
                //Added for JSONSerialization
                print(data)
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray{
                        print(json)
                        
                        var videos = [Videos]()
                        
                        for entry in entries{
                            let entry = Videos(data: entry as! JSONDictionary)
                            videos.append(entry)
                        }
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)){
                            completion(result: "JSONSerialization Successful")
                        }                    }
                }
                catch{
                    dispatch_async(dispatch_get_main_queue()){
                        completion(result: "Error in NSJSONSerialization")
                    }                }
                
            }
        }
        
        task.resume()
    }
    
    
}