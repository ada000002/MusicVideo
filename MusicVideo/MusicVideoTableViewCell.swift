//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by ADA on 16/05/16.
//  Copyright © 2016 Samaclip. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {
    
    var video: Videos?{
        didSet{
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var musicArtist: UILabel!
    @IBOutlet weak var musicDate: UILabel!
    
    func updateCell(){
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        musicArtist.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        musicDate.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        musicTitle.text = video?.vName
        musicArtist.text = video?.vArtist
        musicDate.text = video?.vReleaseDte
        //musicImage.image = UIImage(named: "img_not_found")
        
        if video!.vImageData != nil{
            print("Get data from array...")
            musicImage.image = UIImage(data: video!.vImageData!)
        }
        else{
            GetVideoImage(video!, ImageView: musicImage)
            print("Get images in bg thread")
        }

    }
    
    func GetVideoImage(video: Videos, ImageView: UIImageView){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            var image : UIImage?
            if data != nil{
                video.vImageData = data
                image = UIImage(data: data!)!
            }
            
            dispatch_async(dispatch_get_main_queue()){
                ImageView.image = image
            }
        }
        
    }
}

