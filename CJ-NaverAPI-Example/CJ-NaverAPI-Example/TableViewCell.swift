//
//  TableViewCell.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/08.
//

import UIKit

import Then
import SnapKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"
    
    // 셀 뷰
    let containerView = UIView().then {
        $0.backgroundColor = .black
    }
    
    let cellLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "이건 셀"
    }
    
    // 셀을 만들 때 init을 생성해줘야 한다
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.containerView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setConstraint()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConstraint(){
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.containerView.snp.centerX)
            make.centerY.equalTo(self.containerView.snp.centerY)
        }
    }

}
