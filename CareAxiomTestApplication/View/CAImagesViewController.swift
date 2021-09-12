//
//  CAImagesViewController.swift
//  CareAxiomTestApplication
//
//  Created by Khawaja Salman Nadeem on 11/09/2021.
//

import UIKit

class CAImagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PictureCell")
        self.tableView.register(UINib(nibName: "PictureDataTableViewCell", bundle: nil), forCellReuseIdentifier: "PictureCell")
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(callToViewModelForUIUpdate), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
    }
    
    @objc func callToViewModelForUIUpdate(){
        self.pictureViewModel =  PictureViewModel()
            self.pictureViewModel.bindPictureViewModelToCAImagesViewController = {
                self.loadTableView()
        }
        
        if InternetConnection.sharedInstance.isInternetConnected == false {
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - TableView Delegates & Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = self.pictureViewModel else {return 0}
        guard let data = model.picData else {return 0}
        print("Total Elements to Display = \(data.count)")
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell") as? PictureDataTableViewCell else {return UITableViewCell()}
        guard self.pictureViewModel.picData != nil else {return UITableViewCell()}
        if self.pictureViewModel.picData!.count > indexPath.row {
            let pic = self.pictureViewModel.picData![indexPath.row]
            cell.titleLabel.text = pic.title
            cell.thumbnailUrlLabel.text = pic.thumbnailUrl
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
}
