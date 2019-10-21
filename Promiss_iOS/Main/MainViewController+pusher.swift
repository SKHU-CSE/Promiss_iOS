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
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        })

        pusher.connect()
        self.createCircleAndMarker()
        print("pusher connect")
    }
    
    func disconnectPusher() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let pusher = appDelegate.pusher else {return}
        pusher.disconnect()
        removeCircleAndMarker()
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
}
