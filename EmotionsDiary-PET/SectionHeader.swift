////
////  SectionHeader.swift
////  EmotionsDiary-PET
////
////  Created by Мария Вольвакова on 01.11.2022.
////
//
//import UIKit
//
////MARK: - SectionHeader
//
//class SectionHeader: UICollectionReusableView {
//    
//    static let identifier = "SectionHeader"
//    
//    var label: UILabel = {
//        let label: UILabel = UILabel()
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        return label
//    }()
//    
//    lazy var viewLine: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "lineColor")
//        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        view.layer.masksToBounds = true
//        return view
//    }()
//    
//    var lableAll: UILabel? = {
//        let lable = UILabel()
//        lable.text = "Все"
//        lable.textColor = .systemBlue
//        lable.font = .systemFont(ofSize: 14)
//        return lable
//
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(label)
//        
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//          label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//          label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//          label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//          label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
//        ])
//
//        addSubview(viewLine)
//        viewLine.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//        viewLine.leadingAnchor.constraint(equalTo: label.leadingAnchor),
//        viewLine.trailingAnchor.constraint(equalTo: trailingAnchor),
//        viewLine.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -8)
//        ])
//        
//        addSubview(lableAll!)
//        lableAll!.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            lableAll!.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -5),
//            lableAll!.centerYAnchor.constraint(equalTo:label.centerYAnchor)
//        ])
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
