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
    
    var newEvent = Event()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: nil)
    }
    
    func setupView() {
        view.backgroundColor = .secondarySystemBackground
        title = "Новая запись"
        storageManager.makeStorage()
    }
    
    // MARK: - Creation Images
    
    func createLabels(with text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.text = text
        label.font = .preferredFont(forTextStyle: .footnote)
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

    lazy var situationTextField = createTextFields(with: "Опишите ситуацию")
    lazy var thoughtsTextField = createTextFields(with: "Опишите Ваши мысли в момент ситуации")
    lazy var emotionsTextField = createTextFields(with: "Какие эмоции Вы испытали?")
    lazy var reactionTextField = createTextFields(with: "Какая у Вас была реакция?")


    lazy var situationLabel = createLabels(with: "Ситуация")
    lazy var thoughtsLabel = createLabels(with: "Мысли")
    lazy var emotionsLabel = createLabels(with: "Эмоции")
    lazy var reactionLabel = createLabels(with: "Реакция")
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить запись", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightGray
        button.titleLabel?.textColor = .black
        button.tintColor = .black
        button.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить запись", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.titleLabel?.textColor = .black
        button.tintColor = .black
        button.addTarget(self, action: #selector(deleteEvent), for: .touchUpInside)
        return button
    }()
    
    // Date picker
    
    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.inputView = datePicker
        textField.text = formatDate(date: Date())
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        return textField
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
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTextField.text = formatDate(date: datePicker.date)
    }
    
    @objc func saveEvent() {
        newEvent.date = datePicker.date
        newEvent.situation = situationTextField.text ?? ""
        newEvent.thoughts = thoughtsTextField.text ?? ""
        newEvent.emotions = emotionsTextField.text ?? ""
        newEvent.reaction = reactionTextField.text ?? ""
        storageManager.addEvent(newEvent)
        
    }
    
    @objc func deleteEvent() {
        
    }


// MARK: - Stacks

    lazy var parentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()

    // MARK: - Hierarchy

    func setupHierarchy() {
        view.addSubview(parentStack)

        parentStack.addArrangedSubview(dateTextField)
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
        parentStack.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
    }
}
