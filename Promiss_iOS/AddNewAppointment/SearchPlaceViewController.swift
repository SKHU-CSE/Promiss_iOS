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
    var presentingVC: AddNew2_PlaceViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        searchResultTableView.isHidden = true
    }
    
    @IBAction func clickExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickSetButton(_ sender: Any) {
        let address = self.addressLabel.text ?? ""
        let lat = self.mapCoordination.lat
        let lng = self.mapCoordination.lng
        
        dismiss(animated: true) {
            self.presentingVC?.getPlaceInfo(address: address, lat: lat, lng: lng)
        }
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
        AddressService.shared.getSearchResult(keyword: keyword, latitude: mapCoordination.lat, longitude: mapCoordination.lng) { places in
            
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
    // 지도 탭
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        self.view.endEditing(true)
    }

    // 지도 위치 이동
    func mapView(_ mapView: NMFMapView, regionDidChangeAnimated animated: Bool, byReason reason: Int) {
        mapCoordination = NMGLatLng(lat: mapView.latitude, lng: mapView.longitude)
        AddressService.shared.getAddress(latitude: mapCoordination.lat, longitude: mapCoordination.lng) { addressResult in
            self.addressLabel.text = addressResult.roadNextJibun
        }
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
    
    // 검색 결과 선택
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
    
    // 테이블 뷰 스크롤 시
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
