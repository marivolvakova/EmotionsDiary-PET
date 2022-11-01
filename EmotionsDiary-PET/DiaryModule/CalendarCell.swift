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
    
    let someView: UIView = {
        let someView = UIView()
        someView.layer.shadowColor = UIColor.darkGray.cgColor
        someView.layer.shadowOffset = CGSize(width: 3, height: 3)
        someView.layer.shadowRadius = 2
        someView.layer.shadowOpacity = 0.9
        someView.clipsToBounds = false
        someView.layer.masksToBounds = false
        someView.layer.cornerRadius = 10
        someView.backgroundColor = UIColor(red: 103 / 255, green: 112 / 255, blue: 241 / 255, alpha: 1)
        return someView
    }()
    
    func setupHierarchy() {
        addSubview(someView)
        someView.addSubview(stackView)
        stackView.addArrangedSubview(timeLable)
        stackView.addArrangedSubview(situationLable)
        stackView.addArrangedSubview(emotionsLable)
    }
    
    func setupLayout() {
        someView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(5)
            make.left.equalTo(snp.left).offset(5)
            make.bottom.equalTo(snp.bottom).offset(-5)
            make.right.equalTo(snp.right).offset(-5)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(someView.snp.top).offset(10)
            make.left.equalTo(someView.snp.left).offset(10)
            make.bottom.equalTo(someView.snp.bottom).offset(-10)
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


