//
//  ListHelper.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import UIKit

class ListHelper : NSObject, UITableViewDelegate, UITableViewDataSource {
    let listCellId = "ListCell"
    
    var contoller : ListController? {
        didSet {
          
        }
    }
    let interactor = ListInteractor()
    
    var annotations : [ListArtPlaceViewModel] = []
    
    func reloadData(){
        interactor.getPlacesAnnotations {[weak self] errorMessage, annotations in
            if let message = errorMessage {
                self?.contoller?.showErrorAllert(message: message)
            } else {
                self?.annotations = annotations!
            }
        }
        contoller?.tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func selectedAnnotation() -> ListArtPlaceViewModel? {
        guard let row = contoller?.tableView.indexPathForSelectedRow?.row
            else { return nil }
        return annotations[row]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotations.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let annotation = annotations[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: listCellId)
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: listCellId, for: indexPath)
        }
        cell?.textLabel?.text = "\(annotation.title)\nlat: \(annotation.coordinate.latitude); lng: \(annotation.coordinate.longitude)\n\(annotation.comments)"
        cell?.detailTextLabel?.text = "\(LocationProcessor.distanceToCurLocation(coordinate: annotation.coordinate))"
        return cell!
    }

}
