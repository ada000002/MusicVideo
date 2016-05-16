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
        musicTitle.text = video?.vName
        musicArtist.text = video?.vArtist
        musicDate.text = video?.vReleaseDte
        //musicImage.image = UIImage(named: "img_not_found")
    }
}

