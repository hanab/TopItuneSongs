//
//  DetailViewController.swift
//  TopItuneSongs
//
//  Created by Hana  Demas on 8/25/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
     //MARK: Properties
    var selectedSong:Song?
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var updatedLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bandImageView: UIImageView!
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Song Detail"
        
        styleUI()
        setUPView()
    }
    
    private func styleUI() {
        updatedLabel.font = UIFont.itunesRegular(12)
        artistLabel.font = UIFont.itunesRegular(12)
        priceLabel.font = UIFont.itunesRegular(12)
        titleLabel.font = UIFont.itunesRegular(17)
        updatedLabel.textColor = UIColor.itunesGray()
        artistLabel.textColor = UIColor.itunesGray()
        priceLabel.textColor = UIColor.itunesGray()
        
    }
    
    private func setUPView() {
        if let song = selectedSong {
            updatedLabel.text = song.updated
            titleLabel.text = song.title
            artistLabel.text = song.artist
            priceLabel.text =  song.price
            bandImageView.loadImageUsingCacheWithURLString(song.imageUrl , placeHolder:  UIImage(named: "rihana"))
        }
    }
}
