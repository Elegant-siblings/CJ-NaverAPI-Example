//
//  mapViewController.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/07.
//
import UIKit

import Foundation
import SnapKit
import Then


class mapViewController: UIViewController {
//    lazy var sampleView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }()
    
    
    let rectView = UIView().then{
        $0.backgroundColor = .red
    }
    
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "Hello, Then"
    }
    
    let tableView = UITableView().then{
        $0.backgroundColor = .cyan
        $0.separatorStyle = .none
        $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 150
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.titleView = rectView
        
        self.view.addSubview(rectView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(tableView)
        
        setConstraint()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func setConstraint() {
        rectView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.width.equalTo(self.view)
            make.height.equalTo(70)
            make.top.equalTo(self.view)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(rectView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        
    }
    
}

extension mapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath)
        return cell
    }
}


import SwiftUI
struct VCPreview: PreviewProvider {
        // Device 배열로 여러 개의 디바이스에 적용된 모습을 같이 확인할 수 있습니다.
        // 저는 지금 3가지의 Device를 사용하고 있죠.
    static var devices = ["iPhone SE", "iPhone 11 Pro Max", "iPhone 12"]

    static var previews: some View {
        ForEach(devices, id: \.self) { deviceName in
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "mapViewController")
                                // 익스텐션에서 만든 toPreview() 메서드를 사용하고 있죠!
                .toPreview()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
