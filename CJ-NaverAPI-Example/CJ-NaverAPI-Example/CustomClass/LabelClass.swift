//
//  LabelClass.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/23.
//

import Foundation
import UIKit
import Then

public enum LabelType {
    case main
}

class MainLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }
        
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame:CGRect.zero)
    }
    
    // 보조 이니셜라이저
    convenience init(type: LabelType) {
        self.init()
        
        switch type {
        case .main:
            self.textColor = .black
            self.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
        }
    }
    
    var style: LabelType = .main {
       didSet {
           switch style {
           case .main:
               self.textColor = .black
               self.font = UIFont.AppleSDGothicNeo(.bold, size: 15)
           }
       }
   }
    
}


