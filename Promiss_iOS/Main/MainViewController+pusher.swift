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
