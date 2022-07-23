//
//  BottomSheetViewController.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/23.
//

import Foundation
import PanModal
import Then
import SnapKit

class BottomSheetViewController: UIViewController {
    
    let tableRowHeight = CGFloat(40)
    let titles = ["배송기사", "송장번호", "상품정보", "보내는 분", "받는 분", "보내는 주소", "받는 주소", "요청사항"]
    let contents = ["AXSD-SDXD-****-ZS**", "1233567", "홍삼즙", "다** (053-573-****)", "최** (010-2287-****)", "서울특별시 서초구 양재동 225-5", "서울특별시 서초구 양재동 225-5", "개가 뭅니다"]
    var lists = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh"]
    
    
    
    let tableView = UITableView().then {
//        let table = ListTableView(
//            rowHeight: tableRowHeight,
//            isScrollEnabled: false)
        $0.layer.borderWidth = 0.2
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.borderColor.cgColor
        $0.separatorStyle = .singleLine
        $0.allowsSelection = false
        $0.separatorColor = UIColor.customLightGray
        $0.separatorInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        $0.isScrollEnabled = false
        $0.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
    }
    
    let leftDeliveryItemsLabel = MainLabel(type: .main).then {
        $0.text = "남은 배송 물품 10개"
        $0.textColor = .black
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 16)
    }
    
    let leftDistanceLabel = MainLabel(type: .main).then {
        $0.text = "남은 이동 거리: 124km"
        $0.textColor = .black
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 16)
        
    }
    
    let deliveryEndTimeLabel = MainLabel(type: .main).then {
        $0.text = "배달 종료 시간: 12:30"
        $0.textColor = .black
        $0.font = UIFont.AppleSDGothicNeo(.bold, size: 16)
    }
    
    let deliveryIngButton = MainButton(type: .main).then {
        $0.backgroundColor = .CjRed
        $0.tintColor = .white
        $0.setTitle("배송중", for: .normal)
    }
    let eatingMealButton = MainButton(type: .main).then {
        $0.backgroundColor = .CjRed
        $0.tintColor = .white
        $0.setTitle("식사중", for: .normal)
    }
    let deliveryCompletedButton = MainButton(type: .main).then {
        $0.backgroundColor = .customLightGray
        $0.tintColor = .white
        $0.setTitle("배달 완료", for: .normal)
    }
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubviews([tableView, leftDistanceLabel, leftDeliveryItemsLabel, deliveryEndTimeLabel, deliveryIngButton, eatingMealButton, deliveryCompletedButton])
        
        
        setConstraints()
        
    }
    
    func setConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(CGFloat(lists.count)*tableRowHeight)
        }
        
        //UIButton
        deliveryCompletedButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalTo(Device.width * 0.7)
            make.height.equalTo(36)
        }
        deliveryIngButton.snp.makeConstraints { make in
            make.leading.equalTo(deliveryCompletedButton.snp.leading)
            make.bottom.equalTo(deliveryCompletedButton.snp.top).offset(-20)
            make.width.equalTo(127)
            make.height.equalTo(48)
        }
        eatingMealButton.snp.makeConstraints { make in
            make.trailing.equalTo(deliveryCompletedButton.snp.trailing)
            make.bottom.equalTo(deliveryCompletedButton.snp.top).offset(-20)
            make.width.equalTo(127)
            make.height.equalTo(48)
        }
        
        //UILabel
        leftDeliveryItemsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(leftDistanceLabel.snp.top).offset(-10)
        }
        leftDistanceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(deliveryEndTimeLabel.snp.top).offset(-10)
        }
        deliveryEndTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(deliveryIngButton.snp.top).offset(-10)
        }
    }



}


extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
//        switch indexPath.row {
//        case 0:
//            cell.backgroundColor = UIColor(rgb: 0xD9D9D9)
//            break
//        default:
//            cell.backgroundColor = .white
//        }
        cell.titleLabel.text = titles[indexPath.row]
        cell.contentLabel.text = contents[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}



// MARK: - PanModalPresentable
extension BottomSheetViewController: PanModalPresentable {
    
    
    // 스크롤되는 tableview 나 collectionview 가 있다면 여기에 넣어주면 PanModal 이 모달과 스크롤 뷰 사이에서 팬 제스처를 원활하게 전환합니다.
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(220)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(40)
    }
    
    //드래그로 내려도 화면이 사라지지 않는다
    var allowsDragToDismiss: Bool {
            return false
        }
        
    // BottomSheet 호출 시 백그라운드 색상 지정
    var panModalBackgroundColor: UIColor {
        return UIColor.clear
    }
}
