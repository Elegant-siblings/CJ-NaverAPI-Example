//
//  mapViewController.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/07.
//

import Foundation
import UIKit
import SnapKit


class mapViewController: UIViewController {
    lazy var sampleView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .red
        
        self.view.addSubview(sampleView)
        sampleView.snp.makeConstraints { make in
            make.width.equalTo(self.view)
            make.height.equalTo(70)
            make.top.equalTo(self.view).offset(30)
        }
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
