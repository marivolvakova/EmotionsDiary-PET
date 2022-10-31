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
    
    var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .orange
        return image
    }()
    
    var titleLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 16)
        return lable
    }()
    
    var noteLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.numberOfLines = 3
        return lable
    }()
    
    var timeLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
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
        addSubview(image)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLable)
        stackView.addArrangedSubview(noteLable)
        addSubview(timeLable)
    }
    
    func setupLayout() {
        
        image.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading)
            make.centerY.equalTo(snp.centerY)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(55)
            make.centerY.equalTo(snp.centerY)
        }
        
        timeLable.snp.makeConstraints { make in
            make.trailing.equalTo(snp.trailing)
            make.centerY.equalTo(snp.centerY)
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


