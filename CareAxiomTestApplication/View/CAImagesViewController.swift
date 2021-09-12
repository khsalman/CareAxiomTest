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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PictureCell")
        self.tableView.reloadData()
    }
    
    func callToViewModelForUIUpdate(){
        self.pictureViewModel =  PictureViewModel()
        self.pictureViewModel.bindPictureViewModelToCAImagesViewController = {
            self.loadTableView()
        }
    }
    
    func loadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        if self.pictureViewModel != nil {
            if self.pictureViewModel.picData != nil {
                return self.pictureViewModel.picData!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "PictureCell")
         let pic = self.pictureViewModel.picData![indexPath.row]
        cell.textLabel?.text = pic.title
        cell.detailTextLabel?.text = pic.thumbnailUrl
        return cell
    }
}
