//
//  MainViewController+pusher.swift
//  Promiss_iOS
//
//  Created by 임수현 on 2019/10/20.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation
import PusherSwift
import NMapsMap

extension MainViewController {
    
    func connectPusher(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let pusher = appDelegate.pusher else {return}
        pusher.delegate = self

        // subscribe to channel
        let channel = pusher.subscribe("ProMiss")

        // bind a callback to handle an event
        let _ = channel.bind(eventName: "event_game\(String(AppointmentInfo.shared.id))", eventCallback: { (event: PusherEvent) in
            if let data = event.data {
              // you can parse the data as necessary
                do {
                    let somedata = Data(data.utf8)
                    let json = try JSONDecoder().decode(PusherResult.self, from: somedata)
                    PusherInfo.shared.savePusherInfo(data: json)

                    print("PUSHER INFO")
                    self.updateCircleAndMarker()
                    self.setupFineLabel()
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        })

        pusher.connect()
        self.createCircleAndMarker()
        self.setupFineLabel()
        print("pusher connect")
    }
    
    func disconnectPusher() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let pusher = appDelegate.pusher else {return}
        pusher.disconnect()
        removeCircleAndMarker()
        fineLabel.isHidden = true
    }
}

extension MainViewController: PusherDelegate{
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberMarkers.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "markerInfoCell", for: indexPath) as! MyCollectionViewCell
        
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(named: "marker_destination")
            cell.nameLabel.text = ""
            return cell
        }
        
        switch indexPath.row % 5 {
        case 1:
            cell.imageView.image = UIImage(named: "marker_red")
        case 2:
            cell.imageView.image = UIImage(named: "marker_yellow")
        case 3:
            cell.imageView.image = UIImage(named: "marker_green")
        case 4:
            cell.imageView.image = UIImage(named: "marker_skyblue")
        case 0:
            cell.imageView.image = UIImage(named: "marker_blue")
        default:
            break
        }
        cell.nameLabel.text = memberMarkers[indexPath.row-1].captionText
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            updateCamera(destinationMarker.position.lat, destinationMarker.position.lng)
            return
        }
        
        if memberMarkers[indexPath.row - 1].position.lat != 0 && memberMarkers[indexPath.row - 1].position.lng != 0 {
            updateCamera(memberMarkers[indexPath.row - 1].position.lat, memberMarkers[indexPath.row - 1].position.lng)
            return
        }
        
        let alert = UIAlertController(title: "사용자 위치 확인", message: "사용자의 위치를 확인할 수 없습니다.\n잠시 후 시도해주세요.", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title:"확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
