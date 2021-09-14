//
//  CAImagesViewController.swift
//  CareAxiomTestApplication
//
//  Created by Khawaja Salman Nadeem on 11/09/2021.
//

import UIKit

class CAImagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Iboutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables & Constants
    private var pictureViewModel : PictureViewModel!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialiseUI()
        self.callToViewModelForUIUpdate()
    }
    
    // MARK: - Setup Initial UI
    func initialiseUI() {
        self.title = "Pictures Data"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "PictureDataTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.picCellId)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
        self.pictureViewModel =  PictureViewModel()

    }
    
    // MARK: - Methods loading table & refresh table
    @objc func refreshData() {
        self.pictureViewModel.getPicturesData()
        if InternetConnection.sharedInstance.isInternetConnected == false {
            self.refreshControl.endRefreshing()
        }
    }
    
    func callToViewModelForUIUpdate(){
            self.pictureViewModel.bindPictureViewModelToCAImagesViewController = {
                self.loadTableView()
        }
    }
    
    func loadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - TableView Delegates & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = self.pictureViewModel else {return 0}
        let key = model.getParticularKey(index: section)
        guard let arr = model.picDataDic?.dic[key] else {return 0}
        return arr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = self.pictureViewModel else {return 0}
        return model.getAllKeysCount(picDict: model.picDataDic)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let model = self.pictureViewModel else {return "NIL"}
        return model.getParticularKey(index: section)
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.picCellId) as? PictureDataTableViewCell else {return UITableViewCell()}
            
        guard let model = self.pictureViewModel else {return UITableViewCell()}
        let key = model.getParticularKey(index: indexPath.section)
        guard let picAllData = model.picDataDic?.dic[key]! else {return UITableViewCell()}
        if picAllData.count > indexPath.row {
            let picData = picAllData[indexPath.row]
            cell.titleLabel.text = picData.title
            cell.thumbnailUrlLabel.text = picData.thumbnailUrl
        }else {
            return UITableViewCell()
        }
        return cell
    }
}
