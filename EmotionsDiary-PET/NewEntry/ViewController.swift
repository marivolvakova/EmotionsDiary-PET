//
//  View.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 16.11.2022.
//

import UIKit
import SnapKit

class NewEntryView: UIViewController {
    
    private var model = NewEntryModel().items
    
    private var selectedIndex = 0 {
        didSet {
            let isListPage = model.count - 1 > selectedIndex
            buttonView.setTitle(isListPage ? "Далее" : "Начать!", for: .normal)
            buttonView.backgroundColor = isListPage ? UIColor.systemBlue : .systemGreen
        }
    }
    
    // MARK: - Views
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = model.count
        pageControl.currentPage = 0
        pageControl.preferredIndicatorImage = UIImage(systemName: "circle.fill")
        pageControl.currentPageIndicatorTintColor = .systemBlue
        return pageControl
    }()
    
    lazy var buttonView: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.tintColor = .white
        button.layer.cornerRadius = 44 / 2
        button.addTarget(self, action: #selector(buttonTappedAction(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var situationTextField = createTextFields(with: "Опишите ситуацию")
    lazy var thoughtsTextField = createTextFields(with: "Опишите Ваши мысли в момент ситуации")
    lazy var emotionsTextField = createTextFields(with: "Какие эмоции Вы испытали? Спросите себя: «Как мне то, что сейчас происходит? Что я чувствую в ответ на это?» Для помощи в поиске верного описания нажмите на кнопку инфо, из таблицы выберете несколько слов, которые лучше всего отражает ваше состояние")
    lazy var reactionTextField = createTextFields(with: "Какая у Вас была реакция?")
    
    func createTextFields(with placeholderText: String) -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = placeholderText
        textField.allowsEditingTextAttributes = true
        textField.backgroundColor = .white
        textField.clearsOnBeginEditing = true
        textField.keyboardAppearance = .dark
        textField.keyboardType = .default
        textField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    lazy var emotionsInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 103 / 255, green: 112 / 255, blue: 241 / 255, alpha: 1)
        return button
    }()
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        let localeID = Locale.preferredLanguages.first
        formatter.locale = Locale(identifier: localeID!)
        formatter.dateFormat = "E, d MMMM, HH:mm"
        return formatter.string(from: date)
    }
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()
    
    lazy var labels: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Choose the date"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        
        view.backgroundColor = UIColor.white
        selectedIndex = 0
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(buttonView)
        
        view.addSubview(closeButton)
        view.addSubview(labels)
        view.addSubview(datePicker)
//        view.addSubview(situationTextField)
//        view.addSubview(thoughtsTextField)
//        view.addSubview(emotionsInfoButton)
//        view.addSubview(emotionsTextField)
//        view.addSubview(reactionTextField)
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(350)
            make.left.equalTo(view.snp.left).offset(40)
            make.right.equalTo(view.snp.right).offset(-40)
            make.bottom.equalTo(view.snp.bottom).offset(-200)
        }
        
        buttonView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(buttonView.snp.top).offset(-30)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        
        
        labels.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(300)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(labels.snp.bottom).offset(100)
            make.centerX.equalTo(view.snp.centerX).offset(-10)
        }

//        situationTextField.snp.makeConstraints { make in
//            make.top.equalTo(situationLabel.snp.bottom).offset(15)
//            make.left.equalTo(view.snp.left).offset(18)
//            make.right.equalTo(view.snp.right).offset(-18)
//        }
//
//        thoughtsTextField.snp.makeConstraints { make in
//            make.top.equalTo(thoughtsLabel.snp.bottom).offset(15)
//            make.left.equalTo(view.snp.left).offset(18)
//            make.right.equalTo(view.snp.right).offset(-18)
//        }
//
//        emotionsInfoButton.snp.makeConstraints { make in
//            make.centerY.equalTo(emotionsLabel.snp.centerY)
//            make.left.equalTo(emotionsLabel.snp.right).offset(10)
//
//        }
//        emotionsTextField.snp.makeConstraints { make in
//            make.top.equalTo(emotionsLabel.snp.bottom).offset(15)
//            make.left.equalTo(view.snp.left).offset(18)
//            make.right.equalTo(view.snp.right).offset(-18)
//        }
//
//        reactionTextField.snp.makeConstraints { make in
//            make.top.equalTo(reactionLabel.snp.bottom).offset(15)
//            make.left.equalTo(view.snp.left).offset(18)
//            make.right.equalTo(view.snp.right).offset(-18)
//        }
    }
}

// MARL: - Action
extension NewEntryView {
    @objc private func buttonTappedAction(_ sender: Any) {
        switch selectedIndex {
        case 0:
            selectedIndex += 1
            pageControl.currentPage += 1
            
                    case 1:
            selectedIndex += 1
            pageControl.currentPage += 1
            
            labels.text = "Как вы себя сегодня чувствуете?"
            
            //        case 2:
            //
            //        }
            //        if model.count - 1 > selectedIndex {
            //
            //            selectedIndex += 1
            //            pageControl.currentPage += 1
            //        } else {
            //            SceneDelegate.shared.changeViewController(viewController: CalendarViewController(), animationOptions: .transitionCrossDissolve)
            //        }
        default:
            selectedIndex += 1
            pageControl.currentPage += 1
        }
    }
}
