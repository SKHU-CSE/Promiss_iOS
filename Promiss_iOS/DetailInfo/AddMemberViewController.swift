//
//  AddMemberViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 25/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func clickExitButton(_ sender: Any) { self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickInviteButton(_ sender: Any) {
        showInviteAlert()
    }
}

extension AddMemberViewController {
    func showInviteAlert() {
        let alert = UIAlertController(title: "초대 완료", message: "새로운 멤버를 초대하였습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func getAppointmentDetailInfo(){
        
    }
}
