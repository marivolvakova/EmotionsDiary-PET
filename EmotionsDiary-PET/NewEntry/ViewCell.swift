//
//  ViewController.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 16.11.2022.
//

import Foundation
import UIKit
import SnapKit

//class NewEntryCell: UICollectionViewCell {
//    
//    static let identifier = "NewEntryCell"
//    
//    // MARK: - Views
//    
//    private lazy var stackView: UIStackView = {
//        let view = UIStackView()
//        view.axis = .vertical
//        view.spacing = 5
//        view.distribution = .equalSpacing
//        return view
//    }()
//    
//    private lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 2
//        label.font = .boldSystemFont(ofSize: 20)
//        label.textColor = .black
//        return label
//    }()
//    
//    lazy var datePicker: UIDatePicker = {
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .dateAndTime
//        let localeID = Locale.preferredLanguages.first
//        datePicker.locale = Locale(identifier: localeID!)
//        datePicker.frame.size = CGSize(width: 50, height: 50)
//        datePicker.preferredDatePickerStyle = .compact
//        return datePicker
//    }()
//    
////    private lazy var descriptionLabel: UILabel = {
////        let label = UILabel()
////        label.textAlignment = .center
////        label.numberOfLines = 0
////        label.font = .systemFont(ofSize: 17)
////        label.textColor = .secondaryLabel
////        return label
////    }()
//    
//    private lazy var textField: UITextField = {
//        let textField = UITextField()
//        textField.textAlignment = .left
//        textField.allowsEditingTextAttributes = true
//        textField.backgroundColor = .white
//        textField.clearsOnBeginEditing = true
//        textField.keyboardAppearance = .dark
//        textField.keyboardType = .default
//        textField.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        textField.layer.cornerRadius = 10
//        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
//        textField.leftViewMode = .always
//        return textField
//    }()
//    
//    // MARK: - Initial
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//    
//    private func commonInit() {
//        backgroundColor = .white
//        setupHierarchy()
//        setupLayout()
//        self.backgroundColor = .secondarySystemBackground
//    }
//    
//    // MARK: - Settings
//    private func setupHierarchy() {
//        addSubview(stackView)
//        
//        stackView.addArrangedSubview(titleLabel)
//        stackView.addArrangedSubview(textField)
//        stackView.addArrangedSubview(datePicker)
//    }
//    
//    private func setupLayout() {
//        stackView.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.top).offset(40)
//            make.left.equalTo(self.snp.left).offset(40)
//            make.right.equalTo(self.snp.right).offset(-40)
//            make.bottom.equalTo(self.snp.bottom).offset(-40)
//        }
//        
//        textField.snp.makeConstraints { make in
//            make.height.equalTo(100)
//        }
//    }
//    
//    // MARK: - Configuration
//    func configureView(with model: NewEntry) {
//        titleLabel.text = model.title
//        textField.placeholder = model.placeholderText
//        
//        if let modelTextField = model.textField {
//            textField = modelTextField
//        } else {
//            textField.isHidden = true
//        }
//        
//        if let modelDatePicker = model.datePicker {
//            datePicker = modelDatePicker
//        } else {
//            datePicker.isHidden = true
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
