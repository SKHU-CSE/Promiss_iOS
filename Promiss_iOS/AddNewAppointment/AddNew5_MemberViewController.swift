//
//  AddNew5_MemberViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class AddNew5_MemberViewController: UIViewController {

    @IBOutlet weak var memberView: UIView!
    @IBOutlet weak var memberSearchTextField: UITextField!
    @IBOutlet weak var memberSearchTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var userList: [UserData?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDesign()
        setupDelegate()
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickExitButton(_ sender: Any) {
        showExitAlert()
    }
    
    @IBAction func clickNextButton(_ sender: Any) {
        let info = AppointmentInfo.shared
        
        AppointmentService.shared.addAppointment(
            id: UserInfo.shared.id,
            name: info.name,
            address: info.address,
            detail: info.detailAddress ?? "",
            latitude: info.latitude,
            longitude: info.longitude,
            date: info.dateString,
            time: info.timeString,
            fineTime: info.fineTime,
            fineMoney: info.fineMoney,
            members: []) { addResult in
                
            switch addResult.result {
            case 1000:  //fail
                self.showFailAlert()
            case 2000:  //success
                guard let data = addResult.data else {return}
                AppointmentInfo.shared.saveAppointmentInfo(data: data)
                self.showNextViewController()
            default:
                return
            }
        }
    }
}

extension AddNew5_MemberViewController {
    func setupViewDesign() {
        memberView.setAsWhiteBorderView()
        nextButton.setAsYellowButton()
    }
    
    func setupDelegate(){
        memberSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        memberSearchTextField.delegate = self
        memberSearchTableView.delegate = self
        memberSearchTableView.dataSource = self
    }
    
    func showExitAlert() {
        let alert = UIAlertController(title: "약속만들기 취소", message: "약속 정보가 저장되지 않습니다.\n정말로 취소하시겠습니까?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "계속 만들기", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "만들기 취소", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func showFailAlert() {
        let alert = UIAlertController(title: "약속만들기 실패", message: "약속만들기에 실패하였습니다.\n잠시 후에 시도해주세요.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func showNextViewController() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addNew6") else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension AddNew5_MemberViewController: UITextFieldDelegate{
    @objc func textFieldDidChange(_ textfield: UITextField){
        guard let keyword = textfield.text else {return}
        UserService.shared.findUser(userID: keyword) { data in
            self.userList.removeAll()
            for user in data{
                self.userList.append(user)
            }
            self.memberSearchTableView.reloadData()
        }
    }
}

extension AddNew5_MemberViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel!.text = userList[indexPath.row]?.user_name
        cell.detailTextLabel!.text = "+"
        return cell
    }
}
