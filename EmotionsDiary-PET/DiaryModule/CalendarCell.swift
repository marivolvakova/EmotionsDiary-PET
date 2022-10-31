//
//  CalendarCell.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 29.10.2022.
//

import UIKit
import SnapKit

class CalendarCell: UITableViewCell {
    
    static let identifier = "CalendarTableViewCell"
        
    var timeLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 16)
        return lable
    }()
    
    var situationLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = .systemFont(ofSize: 14, weight: .bold)
        lable.numberOfLines = 1
        return lable
    }()
    
    var emotionsLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = .systemFont(ofSize: 12, weight: .regular)
        lable.numberOfLines = 1
        return lable
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading

        return stackView
    }()
    
    func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(timeLable)
        stackView.addArrangedSubview(situationLable)
        stackView.addArrangedSubview(emotionsLable)
    }
    
    func setupLayout() {
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.equalTo(snp.left).offset(10)
            make.bottom.equalTo(snp.bottom).offset(-10)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


