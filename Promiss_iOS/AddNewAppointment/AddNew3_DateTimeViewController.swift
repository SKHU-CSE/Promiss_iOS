//
//  AddNew3_DateTimeViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class AddNew3_DateTimeViewController: UIViewController {

    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickExitButton(_ sender: Any) {
        showExitAlert()
    }
    
    @IBAction func clickNextButton(_ sender: Any) {
        showNextViewController()
    }
}

extension AddNew3_DateTimeViewController {
    
    private func setView() {
        dateButton.setWhiteBorder()
        timeButton.setWhiteBorder()
        nextButton.setAsYellowButton()
        
        let after3Hours = Date(timeIntervalSinceNow: 60*60*3)
        dateButton.setTitle(getDateString(date: after3Hours), for: .normal)
        timeButton.setTitle(getTimeString(date: after3Hours), for: .normal)
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
    
    func showNextViewController() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addNew4") else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
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
    
    func getTimeString(date: Date) -> String {
        let hourFormatter = DateFormatter()
        
        hourFormatter.dateFormat = "HH"
        let hour = Int(hourFormatter.string(from: date)) ?? 0
        let ampm = (hour >= 12) ? "오전" : "오후"
        
        hourFormatter.dateFormat = "hh:mm"
        let timeString = hourFormatter.string(from: date)
        
        return "\(ampm) \(timeString)"
    }
}
