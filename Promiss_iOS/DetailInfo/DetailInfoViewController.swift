//
//  DetailInfoViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 25/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailAddressTextField: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var fineLabel: UILabel!
    
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var appointmentCancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDesign()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getDetailInfo()
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
    func setupViewDesign() {
        plusButton.setImage(UIImage(named: "btn_plus"), for: .normal)
        appointmentCancelButton.layer.cornerRadius = 6
    }
    
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
    
    func getDetailInfo(){
        AppointmentService.shared.getDetailAppointmentInfo(id: AppointmentInfo.shared.id) { detailResult in
            
            switch detailResult.result{
            case 2000:
                guard let data = detailResult.data else { return }
                self.nameLabel.text = data.name
                self.addressLabel.text = data.address
                self.detailAddressTextField.text = data.detail
                self.detailAddressTextField.isEditable = false
                self.dateLabel.text = self.getDateString(org: data.date)
                self.timeLabel.text = self.getDateTimeString(org: data.dateTime)
                self.fineLabel.text = "\(data.fineTime)분 마다 \(data.fineMoney)원"
                self.memberCountLabel.text = "(총 \(data.members?.count ?? 0)명)"
                
            default:
                break
            }
        }
    }
    
    func getDateString(org: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date: Date = dateFormatter.date(from: org) else {return org}

        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    func getDateTimeString(org: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"

        guard let time: Date = dateFormatter.date(from: org) else {return org}
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: time)
        var ampm = "오전"
        if components.hour! > 12 {
            ampm = "오후"
        }
        
        dateFormatter.dateFormat = "hh:mm"
        return "\(ampm) \(dateFormatter.string(from: time))"
    }
}