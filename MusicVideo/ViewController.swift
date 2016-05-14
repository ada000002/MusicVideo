//
//  ViewController.swift
//  MusicVideo
//
//  Created by ADA on 14/05/16.
//  Copyright © 2016 Samaclip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }

    func didLoadData(videos: [Videos]){
        print(reachabilityStatus)
        for item in videos{
            print("name = \(item.vName)")
        }
    }
    
    
}

