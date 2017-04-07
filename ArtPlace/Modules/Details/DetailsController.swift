//
//  DetailsController.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class DetailsArtPlaceViewModel {
    var objetctID : NSManagedObjectID
    var title : String
    var comments : String
    var coordinate : CLLocationCoordinate2D
    
    init(objetctID : NSManagedObjectID, title : String, comments : String, coordinate : CLLocationCoordinate2D) {
        self.objetctID = objetctID
        self.title = title
        self.comments = comments
        self.coordinate = coordinate
    }
}

class DetailsController : UIViewController {
    
    @IBOutlet weak var content: UIScrollView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var commentField: UITextView!
    
    var artPlace : DetailsArtPlaceViewModel?
    
    let interactor = DetailsInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        nameField.text = artPlace?.title
        commentField.text = artPlace?.comments
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(switchKeyboard),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(switchKeyboard),
            name: Notification.Name.UIKeyboardWillChangeFrame,
            object: nil)
    }

    func switchKeyboard(notification: Notification){
        let keyboardScreenEndFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        let contentInsets = (notification.name == Notification.Name.UIKeyboardWillHide)  ?
            UIEdgeInsets.zero :
            UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)

        content.scrollIndicatorInsets = contentInsets
        content.contentInset = contentInsets
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        artPlace?.title = nameField.text!
        artPlace?.comments = commentField.text!
        interactor.updateArtObject(artPlace: artPlace!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
