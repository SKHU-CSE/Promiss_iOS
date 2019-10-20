//
//  AddMemberViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 25/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit
import TagListView

class AddMemberViewController: UIViewController {

    @IBOutlet weak var memberListView: TagListView!
    @IBOutlet weak var userSearchTextField: UITextField!
    @IBOutlet weak var userSearchTableView: UITableView!
    
    var userList: [UserData?] = []
    var invitedMemberDict = Dictionary<String, Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesgin()
        setupDelegate()
    }
    
    @IBAction func clickExitButton(_ sender: Any) { self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickInviteButton(_ sender: Any) {
        invitedMemberDict.removeValue(forKey: UserInfo.shared.userId)
        let members: [Int] = Array(invitedMemberDict.values)
        print(members)
        AppointmentService.shared.inviteMembers(appointID: AppointmentInfo.shared.id, num: members.count, members: members) {
            self.showInviteAlert()
        }
    }
}

extension AddMemberViewController {
    func setupDesgin(){
        memberListView.backgroundColor = UIColor.clear
        userSearchTextField.setWhiteBorder()
    }
    
    func setupDelegate() {
        userSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        userSearchTextField.delegate = self
        
        userSearchTableView.delegate = self
        userSearchTableView.dataSource = self
        
        memberListView.delegate = self
    }
    
    func showInviteAlert() {
        let alert = UIAlertController(title: "초대 완료", message: "새로운 멤버를 초대하였습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

extension AddMemberViewController: UITextFieldDelegate{
    @objc func textFieldDidChange(_ textfield: UITextField){
        guard let keyword = textfield.text else {return}
        UserService.shared.findUser(userID: keyword) { data in
            self.userList.removeAll()
            for user in data{
                self.userList.append(user)
            }
            self.userSearchTableView.reloadData()
        }
    }
}

extension AddMemberViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        let userName = userList[indexPath.row]?.user_name ?? "unknown"
        cell.textLabel!.text = userName
        
        if invitedMemberDict.keys.contains(userName) {
            cell.detailTextLabel!.text = "초대됨"
            
        } else if userList[indexPath.row]?.appointment_id == AppointmentInfo.shared.id {
            cell.detailTextLabel!.text = "초대됨"
            
        } else {
            cell.detailTextLabel!.text = "+"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let data = userList[indexPath.row] else {return}
        if invitedMemberDict.keys.contains(data.user_name) {
            cell?.isSelected = false
            return
        }
        inviteMember(cell: cell, name: data.user_name, id: data.id)
    }
    
    func inviteMember(cell: UITableViewCell?, name: String, id: Int){
        cell?.detailTextLabel?.text = "초대됨"
        memberListView.addTag(name)
        invitedMemberDict.updateValue(id, forKey: name)
        userSearchTableView.reloadData()
    }
    
    func removeMember(title: String){
        memberListView.removeTag(title)
        invitedMemberDict.removeValue(forKey: title)
        userSearchTableView.reloadData()
    }
}

extension AddMemberViewController: TagListViewDelegate {
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        removeMember(title: title)
    }
}
