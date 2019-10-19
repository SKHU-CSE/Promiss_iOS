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
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var placesList: [SearchPlaceResult.Place] = []
    var mapCoordination: NMGLatLng = NMGLatLng(lat: 37.541, lng: 126.986)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        searchResultTableView.isHidden = true
    }
    
    @IBAction func clickExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchPlaceViewController {
    func setDelegate(){
        mapView.delegate = self
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
}

extension SearchPlaceViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text != "" {
            searchResultTableView.isHidden = false
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let keyword: String = textField.text ?? ""
        
        // 검색 결과 테이블 뷰 숨기기, 보이기
        if keyword == "" {
            searchResultTableView.isHidden = true
            return
        }
        searchResultTableView.isHidden = false
        
        // 검색 (서버통신)
        SearchPlaceService.shared.getSearchResult(keyword: keyword, latitude: mapCoordination.lat, longitude: mapCoordination.lng) { places in
            
            self.placesList.removeAll()
            for place in places {
                print(place.name)
                self.placesList.append(place)
            }
            self.searchResultTableView.reloadData()
        }
    }
}

extension SearchPlaceViewController: NMFMapViewDelegate{
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        self.view.endEditing(true)
    }

    func mapViewRegionIsChanging(_ mapView: NMFMapView, byReason reason: Int) {
        mapCoordination = NMGLatLng(lat: mapView.latitude, lng: mapView.longitude)
    }
}

extension SearchPlaceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

        cell.textLabel!.text = placesList[indexPath.row].name
        cell.detailTextLabel!.text =  placesList[indexPath.row].address()
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = placesList[indexPath.row]

        // 검색결과 테이블 뷰 숨기기
        searchResultTableView.isHidden = true
        
        // 키보드 내리기
        self.view.endEditing(true)
        
        // 카메라 이동
        let latitude = Double(place.y) ?? mapCoordination.lat
        let longitude = Double(place.x) ?? mapCoordination.lng
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        cameraUpdate.animation = .fly
        mapView.moveCamera(cameraUpdate)
        
        // 주소 업데이트
        addressLabel.text = place.address()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
