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
            
            dispatch_async(dispatch_get_main_queue()){
                if error != nil {
                    completion(result: (error!.localizedDescription))
                }
                else{
                    completion(result: "NSURLSession successful")
                    print(data)
                }
            }
        }
        
        task.resume()
    }
    
    
}