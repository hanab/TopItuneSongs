//
//  ViewController.swift
//  TopItuneSongs
//
//  Created by Hana  Demas on 8/24/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import UIKit
import SafariServices
import Network

class ListViewController: UIViewController, SFSafariViewControllerDelegate {
    
    //MARK: Properties
    var viewModel = SongsViewModel()
    fileprivate let cellId = "cell"
    
    @IBOutlet var songsTableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(ListViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.itunesGray()
        
        return refreshControl
    }()
    
    //MARK: LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songsTableView.dataSource = self
        songsTableView.delegate = self
        
        songsTableView.rowHeight = UITableView.automaticDimension
        songsTableView.estimatedRowHeight = 100
        songsTableView.separatorColor = UIColor.itunesBlue()
        self.navigationController?.navigationBar.barTintColor =  UIColor.itunesBlue()
        self.navigationItem.title = "Top Songs"
        
        songsTableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let destination = segue.destination as? DetailViewController, let indexPath = songsTableView.indexPathForSelectedRow {
                destination.selectedSong = viewModel.getSongAtIndex(index: indexPath.row)
            }
        }
    }
    
    //MARK:SFSafariViewControllerDelegate methods
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
    
    //MARK: Methods
    func loadData() {
        viewModel = SongsViewModel()
        
        CheckConectivity.shared.online { (err) in
            if err != false {
                DispatchQueue.main.async {
                    self.displayAlertWith(title: "Offline", message: "Please Check your internet connectivity", buttonTitle: "OK")
                }
            } else {
                self.viewModel.fetchData {
                    DispatchQueue.main.async {
                        self.songsTableView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
        refreshControl.endRefreshing()
    }
    
    func showMusic(link: String) {
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            //config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            vc.preferredBarTintColor = UIColor.itunesBlue()
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            
            present(vc, animated: true)
        }
    }
}

//MARK: viewcontroller extension for implementing datasource and delegates of uitableview
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: tableview datasource
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfSongs()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SongTableViewCell
        cell.setupSongCell(song: viewModel.getSongAtIndex(index: indexPath.row))
        cell.playButtonAction = { [unowned self] in
            self.showMusic(link: self.viewModel.getSongAtIndex(index: indexPath.row)?.previewLink ?? "")
        }
        return cell
    }
    
    //MARK: tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: tableView)
        self.songsTableView.deselectRow(at: self.songsTableView.indexPathForSelectedRow!, animated: true)
    }
}
