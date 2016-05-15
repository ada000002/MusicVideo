//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by ADA on 15/05/16.
//  Copyright © 2016 Samaclip. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
    }
    
    func didLoadData(videos: [Videos]){
        print(reachabilityStatus)
        self.videos = videos
        for item in videos{
            print("name = \(item.vName)")
        }
        
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged(){
        switch reachabilityStatus{
        case NOACCESS :
            view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue()){
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default){
                action-> Void in
                print("Cancel")
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive){
                action-> Void in
                print("Delete")
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .Default){
                action-> Void in
                print("Ok")
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            }
        default:
            view.backgroundColor = UIColor.greenColor()
            if videos.count > 0{
                runAPI()
            }
            else{
                print("Do not refresh API")
            }
        }
    }
    
    
    func runAPI(){
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=30/json", completion: didLoadData)
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        return cell
    }
    
}
