//
//  APIManager.swift
//  MusicVideo
//
//  Created by ADA on 14/05/16.
//  Copyright © 2016 Samaclip. All rights reserved.
//

import Foundation

class APIManager{
    func loadData(urlString:String, completion:[Videos]-> Void){
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        //let session = NSURLSession.sharedSession()
        let url = NSURL(string:urlString)!
        
        let task = session.dataTaskWithURL(url){
            (data, respose, error)-> Void in
            
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                //Added for JSONSerialization
                print(data)
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray{
                        //print(json)
                        
                        var videos = [Videos]()
                        
                        for entry in entries{
                            let entry = Videos(data: entry as! JSONDictionary)
                            videos.append(entry)
                        }
                        
                        let i = videos.count
                        print("iTunesApiManager - total count --> \(i)")
                        print(" ")
                        
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)){
                            completion(videos)
                        }                    }
                }
                catch{
                    print("Error in NSJSONSerialization")
                }
                
            }
        }
        
        task.resume()
    }
}