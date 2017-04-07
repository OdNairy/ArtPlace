//
//  ListController.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class ListArtPlaceViewModel {
    let objetctID : NSManagedObjectID
    let title : String
    let comments : String
    let coordinate : CLLocationCoordinate2D
    
    init(objetctID : NSManagedObjectID, title : String, comments : String, coordinate : CLLocationCoordinate2D) {
        self.objetctID = objetctID
        self.title = title
        self.comments = comments
        self.coordinate = coordinate
    }
}

class ListController : UITableViewController {
    
    let helper = ListHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.contoller = self
        tableView.delegate = helper
        tableView.dataSource = helper
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsController = segue.destination as? DetailsController {
            if  let selectedListViewModel = helper.selectedAnnotation() {
                let detailsViewModel = DetailsArtPlaceViewModel(objetctID: selectedListViewModel.objetctID,
                                                                title: selectedListViewModel.title,
                                                                comments: selectedListViewModel.comments,
                                                                coordinate: selectedListViewModel.coordinate)
                detailsController.artPlace = detailsViewModel
            }

        }
    }


}
