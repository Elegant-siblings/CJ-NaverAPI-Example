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
        $0.textColor = .blue
        $0.text = "Hello, Then"
    }
    
    let tableView = UITableView().then{
        $0.backgroundColor = .black
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
            make.centerX.equalTo(self.view)
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

struct MapViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = mapViewController
    
    func makeUIViewController(context: Context) -> mapViewController {
        return mapViewController()
    }
    
    func updateUIViewController(_ uiViewController: mapViewController, context: Context) {}
}

struct MapViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            MapViewControllerRepresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
                .previewDisplayName("iPhone 13 Pro")
            
            MapViewControllerRepresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}


