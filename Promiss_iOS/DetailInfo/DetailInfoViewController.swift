//
//  DetailInfoViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 25/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickAppointmentCancelButton(_ sender: Any) {
        showCancelAlert()
    }
    @IBAction func clickAddMemberButton(_ sender: Any) {
        goToAddMemberVC()
    }
}

extension DetailInfoViewController {
    func goToAddMemberVC() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addMember") else {
            print("addMember 없음")
            return
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func showCancelAlert() {
        let alert = UIAlertController(title: "약속 나가기", message: "현재 약속에 다시 참여하고 싶으면,\n 현재 약속 멤버가 다시 초대를 해 주어야 합니다.\n 정말로 나가시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "나가기", style: .destructive, handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
