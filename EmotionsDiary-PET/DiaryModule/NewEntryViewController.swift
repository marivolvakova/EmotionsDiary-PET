//
//  NewEntryViewController.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 29.10.2022.
//

import UIKit
import SnapKit

class NewEntryViewController: UIViewController {
    var storageManager = StorageManager()
    var calendarView = CalendarView()
    
    lazy var situationTextField = createTextFields(with: "Опишите ситуацию")
    lazy var thoughtsTextField = createTextFields(with: "Опишите Ваши мысли в момент ситуации")
    lazy var emotionsTextField = createTextFields(with: "Какие эмоции Вы испытали? Спросите себя: «Как мне то, что сейчас происходит? Что я чувствую в ответ на это?» Для помощи в поиске верного описания нажмите на кнопку инфо, из таблицы выберете несколько слов, которые лучше всего отражает ваше состояние")
    lazy var reactionTextField = createTextFields(with: "Какая у Вас была реакция?")
    
    lazy var situationLabel = createLabels(with: "Ситуация")
    lazy var thoughtsLabel = createLabels(with: "Мысли")
    lazy var emotionsLabel = createLabels(with: "Эмоции")
    lazy var reactionLabel = createLabels(with: "Реакция")
    lazy var dateLabel = createLabels(with: "Выберете дату:")
    
    // MARK: - Stacks
    
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
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var emotionsInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 103 / 255, green: 112 / 255, blue: 241 / 255, alpha: 1)
        return button
    }()

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
        let newEvent = Event()
        newEvent.date = datePicker.date
        newEvent.emotions = emotionsTextField.text ?? ""
        newEvent.reaction = reactionTextField.text ?? ""
        newEvent.situation = situationTextField.text ?? ""
        newEvent.thoughts = thoughtsTextField.text ?? ""
        
        storageManager.addEvent(newEvent)
        calendarView.tableView.insertRows(at: [IndexPath(row: 0, section:  storageManager.items.count - 1)], with: .automatic)
        
        DispatchQueue.main.async {
            self.calendarView.tableView.reloadData()
        }
        
        let alert = UIAlertController(title: "Ваша запись успешно сохранена",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: { [self]_ in
            dismiss(animated: true)

        }))
        self.present(alert, animated: true)
    }
    
//    @objc func deleteEvent() {
//
//        let alert = UIAlertController(title: "Подтверждение удаления",
//                                      message: "Вы уверены, что хотите удалить запись?",
//                                      preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Удалить",
//                                      style: .default,
//                                      handler: {_ in
//
//            let
//            self.storageManager.deleteEvent(self.currentEvent)
//            CalendarView().tableView.reloadData()
//        }))
//        alert.addAction(UIAlertAction(title: "Отмена",
//                                      style: .cancel,
//                                      handler: nil))
//        CalendarView().tableView.reloadData()
//        self.present(alert, animated: true)
//    }
    
    // MARK: - Hierarchy
    
    func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        
        view.addSubview(situationLabel)
        view.addSubview(situationTextField)
        view.addSubview(thoughtsLabel)
        view.addSubview(thoughtsTextField)
        view.addSubview(emotionsLabel)
        view.addSubview(emotionsInfoButton)
        view.addSubview(emotionsTextField)
        view.addSubview(reactionLabel)
        view.addSubview(reactionTextField)
        view.addSubview(saveButton)
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
        situationLabel.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
        situationTextField.snp.makeConstraints { make in
            make.top.equalTo(situationLabel.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
        thoughtsLabel.snp.makeConstraints { make in
            make.top.equalTo(situationTextField.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
        thoughtsTextField.snp.makeConstraints { make in
            make.top.equalTo(thoughtsLabel.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
        emotionsLabel.snp.makeConstraints { make in
            make.top.equalTo(thoughtsTextField.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(18)
        }
        emotionsInfoButton.snp.makeConstraints { make in
            make.centerY.equalTo(emotionsLabel.snp.centerY)
            make.left.equalTo(emotionsLabel.snp.right).offset(10)

        }
        emotionsTextField.snp.makeConstraints { make in
            make.top.equalTo(emotionsLabel.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
        reactionLabel.snp.makeConstraints { make in
            make.top.equalTo(emotionsTextField.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
        reactionTextField.snp.makeConstraints { make in
            make.top.equalTo(reactionLabel.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(reactionTextField.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left).offset(18)
            make.right.equalTo(view.snp.right).offset(-18)
        }
    }
}

