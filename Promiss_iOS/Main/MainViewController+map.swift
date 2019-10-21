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
    
    // 내 위치 마커 위치 갱신
    func updateLocationMarker(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees){
        myLocationMarker.position = NMGLatLng(lat: latitude, lng: longitude)
        myLocationMarker.captionText = "내 위치"
    }
    
    // 카메라 위치 갱신
    func updateCamera(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude+0.0005, lng: longitude), zoomTo: 15.0)
        naverMapView.moveCamera(cameraUpdate)
    }
    
    // 원과 멤버 마커 생성
    func createCircleAndMarker() {
        removeCircleAndMarker()
        myLocationMarker.mapView = nil
        
        AppointmentService.shared.getDetailAppointmentInfo(id: AppointmentInfo.shared.id) { detailResult in
            guard let detail = detailResult.data else {return}
            let colors = [UIColor.pmIndiPink, UIColor.yellow, UIColor.pmGreen, UIColor.pmSkyBlue, UIColor.pmSeaBlue]
            
            // 목적지 마커
            self.destinationMarker.position = NMGLatLng(lat: detail.latitude, lng: detail.longitude)
            self.destinationMarker.captionText = detail.name
            self.destinationMarker.iconImage = NMFOverlayImage(name: "marker_destination")
            self.destinationMarker.mapView = self.naverMapView
            
            // 원
            self.circle = NMFCircleOverlay(NMGLatLng(lat: detail.latitude, lng: detail.longitude), radius: detail.radius)
            self.circle.fillColor = UIColor.pmDarkBluewithAlpha
            self.circle.mapView = self.naverMapView
            
            // 멤버 마커
            guard let members = detail.members else {return}
            for i in 0..<members.count {
                let marker = NMFMarker()
                self.memberMarkers.append(marker)
                marker.position = NMGLatLng(lat: members[i].latitude, lng: members[i].longitude)
                switch i%5 {
                case 1:
                    marker.iconImage = NMF_MARKER_IMAGE_RED
                case 2:
                    marker.iconImage = NMF_MARKER_IMAGE_YELLOW
                case 3:
                    marker.iconImage = NMF_MARKER_IMAGE_GREEN
                case 4:
                    marker.iconImage = NMF_MARKER_IMAGE_LIGHTBLUE
                case 0:
                    marker.iconImage = NMF_MARKER_IMAGE_BLUE
                default:
                    return
                }
                marker.captionColor = colors[i%5]
                marker.captionText = members[i].userName
                marker.mapView = self.naverMapView
            }
            
            // 카메라 이동
            let position = NMFCameraPosition(NMGLatLng(lat: detail.latitude, lng: detail.longitude), zoom: 9)
            let update = NMFCameraUpdate(position: position)
            self.naverMapView.moveCamera(update)
        }
    }
    
    // 원과 멤버 마커 갱신
    func updateCircleAndMarker(){
        let info = PusherInfo.shared
        guard let appointmentData = info.appointment, let membersData = info.members else {return}
        
        print(appointmentData.radius)
        circle.radius = appointmentData.radius
        circle.mapView = naverMapView
        
        for i in 0..<membersData.count {
            var marker = NMFMarker()
            if i < memberMarkers.count{
                marker = memberMarkers[i]
            } else {
                memberMarkers.append(marker)
            }
            let member = membersData[i]
            marker.position = NMGLatLng(lat: member.latitude, lng: member.longitude)
            marker.mapView = naverMapView
        }
    }
    
    // 원과 목적지, 멤버 마커 제거
    func removeCircleAndMarker(){
        myLocationMarker.mapView = naverMapView
        
        circle.mapView = nil
        destinationMarker.mapView = nil
        
        for marker in memberMarkers {
            marker.mapView = nil
        }
        memberMarkers.removeAll()
    }
}
