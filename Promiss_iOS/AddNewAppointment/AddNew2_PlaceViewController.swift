//
//  AddNew2_PlaceViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit
import NMapsMap

class AddNew2_PlaceViewController: UIViewController {

    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var detailAddressTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
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
        showNextViewController()
    }
}

extension AddNew2_PlaceViewController {
    func setupViewDesign() {
        addressView.setAsWhiteBorderView()
        detailAddressTextView.setWhiteBorder()
        nextButton.setAsYellowButton()
    }
    
    func setupDelegate() {
        naverMapView.delegate = self
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
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addNew3") as? AddNew3_DateTimeViewController else { return }
        
        AppointmentInfo.shared.address = "성공회대학교"
        AppointmentInfo.shared.detailAddress = "정보과학관 6109 프로젝트실"
        AppointmentInfo.shared.latitude = 37.487117
        AppointmentInfo.shared.longitude = 126.826409
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


extension AddNew2_PlaceViewController: NMFMapViewDelegate{
    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        goToSearchPlace()
        return true
    }
    
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        goToSearchPlace()
    }
    
    func mapViewRegionIsChanging(_ mapView: NMFMapView, byReason reason: Int) {
        goToSearchPlace()
    }
    
    func goToSearchPlace(){
        guard let searchPlaceVC = self.storyboard?.instantiateViewController(withIdentifier: "searchPlaceVC") else { return }
        
        searchPlaceVC.modalPresentationStyle = .fullScreen
        self.present(searchPlaceVC, animated: true, completion: nil)
    }
}
