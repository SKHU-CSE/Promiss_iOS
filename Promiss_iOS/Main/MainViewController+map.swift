//
//  MainViewController+map.swift
//  Promiss_iOS
//
//  Created by 임수현 on 24/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit
import NMapsMap

extension MainViewController: NMFMapViewDelegate {
    func mapViewRegionIsChanging(_ mapView: NMFMapView, byReason reason: Int) {
        if reason == -1 {   // 사용자의 제스처로 지도가 이동되면
            locationFollowMode = false
            print("위치이동")
        }
    }
}
extension MainViewController {
    func setupMapView() {
        naverMapView.delegate = self
    }
    
    // 마커 위치 갱신
    func updateMarker(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees){
        myLocationMarker.position = NMGLatLng(lat: latitude, lng: longitude)
        myLocationMarker.mapView = naverMapView
    }
    
    // 카메라 위치 갱신
    func updateCamera(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude+0.0005, lng: longitude), zoomTo: 15.0)
        naverMapView.moveCamera(cameraUpdate)
    }
}
