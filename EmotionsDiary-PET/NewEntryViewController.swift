//
//  NewEntryViewController.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 29.10.2022.
//

import UIKit
import SnapKit

class NewEntryViewController: UIViewController {
    
    
    var storageManager = StorageManager.shared
    var currentEvent = Event()
    
    lazy var situationTextField = createTextFields(with: "Опишите ситуацию")
    lazy var thoughtsTextField = createTextFields(with: "Опишите Ваши мысли в момент ситуации")
    lazy var emotionsTextField = createTextFields(with: "Какие эмоции Вы испытали?")
    lazy var reactionTextField = createTextFields(with: "Какая у Вас была реакция?")
    
    lazy var situationLabel = createLabels(with: "Ситуация")
    lazy var thoughtsLabel = createLabels(with: "Мысли")
    lazy var emotionsLabel = createLabels(with: "Эмоции")
    lazy var reactionLabel = createLabels(with: "Реакция")
    lazy var dateLabel = createLabels(with: "Выберете дату:")
    
    // MARK: - Stacks
    
    lazy var parentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGreen
        button.titleLabel?.textColor = .black
        button.tintColor = .black
        button.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
//    // Date picker
//    lazy var dateTextField: UITextField = {
//        let textField = UITextField()
//        textField.textAlignment = .center
//        textField.inputView = datePicker
//        textField.text = formatDate(date: Date())
//        textField.font = .systemFont(ofSize: 16, weight: .regular)
//        textField.backgroundColor = .white
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.cornerRadius = 10
//        return textField
//    }()
    
//    func createToolbar() {
//        let toolbar = UIToolbar()
//        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneDatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//       let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker))
//        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolbar.sizeToFit()
//        dateTextField.inputAccessoryView = toolbar
//    }
//
//    @objc func doneDatePicker() {
//    dateTextField.text = formatDate(date: datePicker.date)
//       self.view.endEditing(true)
//     }
//
//     @objc func cancelDatePicker(){
//        self.view.endEditing(true)
//      }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Новая запись"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .secondarySystemBackground
        storageManager.makeStorage()
    }
    
    // MARK: - Creation Images
    
    func createLabels(with text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.text = text
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }
    
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
        datePicker.frame.size = CGSize(width: 100, height: 100)
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()
    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    @objc func saveEvent() {
        storageManager.addEvent(currentEvent)
        
        let alert = UIAlertController(title: "Ваша запись успешно сохранена",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: {_ in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    @objc func deleteEvent() {
        
        let alert = UIAlertController(title: "Подтверждение удаления",
                                      message: "Вы уверены, что хотите удалить запись?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Удалить",
                                      style: .default,
                                      handler: {_ in
            self.storageManager.deleteEvent(self.currentEvent)
        }))
        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel,
                                      handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: - Hierarchy
    
    func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        view.addSubview(parentStack)
        
        parentStack.addArrangedSubview(situationLabel)
        parentStack.addArrangedSubview(situationTextField)
        parentStack.addArrangedSubview(thoughtsLabel)
        parentStack.addArrangedSubview(thoughtsTextField)
        parentStack.addArrangedSubview(emotionsLabel)
        parentStack.addArrangedSubview(emotionsTextField)
        parentStack.addArrangedSubview(reactionLabel)
        parentStack.addArrangedSubview(reactionTextField)
        parentStack.addArrangedSubview(saveButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(18)
            make.centerY.equalTo(datePicker.snp.centerY)
        }
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(30)
            make.right.equalTo(view.snp.right).offset(-18)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        parentStack.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
    }
}

