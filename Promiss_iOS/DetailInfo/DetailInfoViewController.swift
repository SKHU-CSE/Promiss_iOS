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
    @IBOutlet weak var memberTableView: UITableView!
    
    @IBOutlet weak var appointmentCancelButton: UIButton!
    
    var invitedMemberName: [String] = []
    var invitedMemberID: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDesign()
        setupDelegate()
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
    // MARK: - setup
    func setupViewDesign() {
        plusButton.setImage(UIImage(named: "btn_plus"), for: .normal)
        appointmentCancelButton.layer.cornerRadius = 6
    }
    
    func setupDelegate(){
        memberTableView.delegate = self
        memberTableView.dataSource = self
    }

    // MARK: - 뷰 전환
    func goToAddMemberVC() {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addMember") as! AddMemberViewController
        for i in 0..<invitedMemberID.count{
            nextVC.invitedMemberDict.updateValue(invitedMemberID[i], forKey: invitedMemberName[i])
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func showCancelAlert() {
        let alert = UIAlertController(title: "약속 나가기", message: "현재 약속에 다시 참여하고 싶으면,\n 현재 약속 멤버가 다시 초대를 해 주어야 합니다.\n 정말로 나가시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "나가기", style: .destructive, handler: {
            action in
            self.leaveAppointment()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    // MARK: - 통신
    private func getDetailInfo(){ AppointmentService.shared.getDetailAppointmentInfo(id: AppointmentInfo.shared.id) { detailResult in
            
            switch detailResult.result{
            case 2000:
                guard let data = detailResult.data else { return }
                self.setupDetailInfo(data: data)
                
            default:
                break
            }
        }
    }
    
    private func leaveAppointment(){
        AppointmentService.shared.leaveAppointment(id: UserInfo.shared.id, appointmentId: AppointmentInfo.shared.id) { isEnable in
            if isEnable {
                let alert = UIAlertController(title: "약속 나가기", message: "완료되었습니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: {
                    action in
                    AppointmentInfo.shared.clearAppointmentInfo()
                    self.dismiss(animated: true, completion: nil)
                })
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
                return
            }
            
            let alert = UIAlertController(title: "실패", message: "네트워크에 문제가 있습니다. 잠시 후 시도해 주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - 기능
    private func getDateString(org: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date: Date = dateFormatter.date(from: org) else {return org}

        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    private func getDateTimeString(org: String) -> String{
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
    
    private func setupDetailInfo(data: AppointmentData){
        self.nameLabel.text = data.name
        self.addressLabel.text = data.address
        self.detailAddressTextField.text = data.detail
        self.detailAddressTextField.isEditable = false
        self.dateLabel.text = self.getDateString(org: data.date)
        self.timeLabel.text = self.getDateTimeString(org: data.dateTime)
        self.fineLabel.text = "\(data.fineTime)분 마다 \(data.fineMoney)원"
        
        guard let members = data.members else {
            self.memberCountLabel.text = "(총 0명)"
            return
        }
        self.memberCountLabel.text = "(총 \(members.count)명)"
        invitedMemberName.removeAll()
        invitedMemberID.removeAll()
        for mem in members {
            invitedMemberName.append(mem.userName)
            invitedMemberID.append(mem.userID)
        }
        self.memberTableView.reloadData()
    }
}

extension DetailInfoViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invitedMemberName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = invitedMemberName[indexPath.row]
        
       return cell
    }
}
