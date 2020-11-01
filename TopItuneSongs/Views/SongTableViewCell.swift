//
//  SongTableViewCell.swift
//  TopItuneSongs
//
//  Created by Hana  Demas on 8/24/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet var bandLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bandImageView: UIImageView!
    @IBOutlet var playButton: UIButton!
    
    var playButtonAction : (() -> ())?
    
    //MARK: Method
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func styleUI() {
        bandLabel.font = UIFont.itunesRegular(12)
        titleLabel.font = UIFont.itunesRegular(17)
        bandLabel.textColor = UIColor.itunesGray()
    }
    
    func setupSongCell(song: Song?) {
        styleUI()
        if let song = song {
            bandLabel.text = song.artist
            titleLabel.text = song.title
            
            bandImageView.loadImageUsingCacheWithURLString(song.imageUrl , placeHolder:  UIImage(named: "rihana"))
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton){
        playButtonAction?()
    }
}
