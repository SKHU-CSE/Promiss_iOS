//
//  SearchPlaceViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 2019/10/19.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit
import NMapsMap

class SearchPlaceViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var mapView: NMFMapView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var setPlaceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    @IBAction func clickExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchPlaceViewController {
    func setDelegate(){
        searchTextField.delegate = self
        mapView.delegate = self
    }
}

extension SearchPlaceViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension SearchPlaceViewController: NMFMapViewDelegate{
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        self.view.endEditing(true)
    }
}
