//
//  AddNew3_DateTimeViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class AddNew3_DateTimeViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewDesign()
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickExitButton(_ sender: Any) {
        showExitAlert()
    }
    
    @IBAction func clickNextButton(_ sender: Any) {
        if checkAvailableTime() {
            showNextViewController()
        } else {
            showSettingErrorAlert()
        }
    }
}

extension AddNew3_DateTimeViewController {
    // 전체 뷰 세부 디자인 구현
    private func setupViewDesign() {
        let after3Hours = Date(timeIntervalSinceNow: 60*60*3)
        
        setupDatePicker(date: after3Hours)
        
        dateView.setAsWhiteBorderView()
        dateLabel.text = getDateString(date: after3Hours)
        dateLabel.textColor = UIColor.white
        
        timeView.setAsWhiteBorderView()
        timeLabel.text = getTimeString(date: after3Hours)
        timeLabel.textColor = UIColor.white
        
        nextButton.setAsYellowButton()
    }
    
    // 데이트피커 설정
    func setupDatePicker(date: Date) {
        datePicker.minimumDate = date
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.date = date
        datePicker.addTarget(self, action: #selector(changedDate), for: .valueChanged)
    }

    // 닫기 버튼 클릭시 발생하는 alert
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
    
    // 현재시간으로부터 3시간 이전 선택 후 다음버튼 클릭시 발생하는 alert
    func showSettingErrorAlert() {
        let alert = UIAlertController(title: "시간 설정", message: "현재 시간으로부터 3시간 이후의 약속만 생성할 수 있습니다.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    // 올바른 시간 범위 선택 시 다음 뷰로 이동
    func showNextViewController() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addNew4") else { return }
        
        AppointmentInfo.shared.time = datePicker.date
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 데이트피커 값이 변동되면 호출됨
    @objc func changedDate() {
        datePicker.minimumDate = Date(timeIntervalSinceNow: 60*60*3)
        dateLabel.text = getDateString(date: datePicker.date)
        timeLabel.text = getTimeString(date: datePicker.date)
    }
    
    // 날짜 필드 문자열 구하기
    func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let dateString = formatter.string(from: date)
        
        let calendar = Calendar(identifier: .gregorian)
        let weekday = calendar.component(.weekday, from: date)
        var weekdayString = String()
        
        switch weekday % 7 {
        case 0: weekdayString = "(토)"
        case 1: weekdayString = "(일)"
        case 2: weekdayString = "(월)"
        case 3: weekdayString = "(화)"
        case 4: weekdayString = "(수)"
        case 5: weekdayString = "(목)"
        case 6: weekdayString = "(금)"
        default: break
        }
        
        return "\(dateString) \(weekdayString)"
    }
    
    // 시간 필드 문자열 구하기
    func getTimeString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let hour = Int(formatter.string(from: date)) ?? 0
        let ampm = (hour < 12) ? "오전" : "오후"
        
        formatter.dateFormat = "hh:mm"
        let timeString = formatter.string(from: date)
        
        return "\(ampm) \(timeString)"
    }
    
    // 현재시간으로부터 3시간 이후인지 체크
    func checkAvailableTime() -> Bool {
        let interval = datePicker.date.timeIntervalSinceNow
        
        if interval < 3*60*60 - 60 {
            return false
        }
        return true
    }
}
