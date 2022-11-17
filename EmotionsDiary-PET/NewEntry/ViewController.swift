//
//  View.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 16.11.2022.
//

import UIKit
import SnapKit

class NewEntryView: UIViewController {
        
    var activityTypeButtons: [UIButton]!
    let numberOfPages = 6
    private var selectedIndex = 0 {
        didSet {
            let isListPage = numberOfPages - 1 > selectedIndex
            nextButton.setTitle(isListPage ? "Далее" : "Сохранить", for: .normal)
            nextButton.backgroundColor = isListPage ? UIColor.systemBlue : .systemGreen
            
            switch selectedIndex {
            case 0:
                label.text = "Выберете дату и время"
                datePicker.isHidden = false
                
                backButton.isHidden = true
                emojiTopStackView.isHidden = true
                emojiBottomStackView.isHidden = true
                situationTextField.isHidden = true
                thoughtsTextField.isHidden = true
                emotionsTextField.isHidden = true
                reactionTextField.isHidden = true
            case 1:
                label.text = "Как вы себя сегодня чувствуете?"
                emojiTopStackView.isHidden = false
                emojiBottomStackView.isHidden = false
                
                datePicker.isHidden = true
                backButton.isHidden = false
                situationTextField.isHidden = true
                thoughtsTextField.isHidden = true
                emotionsTextField.isHidden = true
                reactionTextField.isHidden = true
            case 2:
                label.text = "Опишите возникшую ситуацию"
                situationTextField.isHidden = false
                
                emojiTopStackView.isHidden = true
                emojiBottomStackView.isHidden = true
                datePicker.isHidden = true
                backButton.isHidden = false
                thoughtsTextField.isHidden = true
                emotionsTextField.isHidden = true
                reactionTextField.isHidden = true
            case 3:
                label.text = "Какие мысли Вас посетили в момент ситуации?"
                thoughtsTextField.isHidden = false
                
                emojiTopStackView.isHidden = true
                emojiBottomStackView.isHidden = true
                datePicker.isHidden = true
                backButton.isHidden = false
                situationTextField.isHidden = true
                emotionsTextField.isHidden = true
                reactionTextField.isHidden = true
            case 4:
                label.text = "Какие чувства Вы испытывали в момент ситуации?"
                emotionsTextField.isHidden = false

                emojiTopStackView.isHidden = true
                emojiBottomStackView.isHidden = true
                datePicker.isHidden = true
                backButton.isHidden = false
                situationTextField.isHidden = true
                reactionTextField.isHidden = true
                thoughtsTextField.isHidden = true
            case 5:
                label.text = "Какая реакция у Вас была? Ваши телесные ощущения и поведение"
                reactionTextField.isHidden = false
                
                emojiTopStackView.isHidden = true
                emojiBottomStackView.isHidden = true
                datePicker.isHidden = true
                backButton.isHidden = false
                situationTextField.isHidden = true
                thoughtsTextField.isHidden = true
                emotionsTextField.isHidden = true
            default:
                self.dismiss(animated: true)
            }
        }
    }
    
    // MARK: - Views
    
    lazy var emojiBottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        return view
    }()
    
    lazy var emojiTopStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        return view
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = 0
        pageControl.preferredIndicatorImage = UIImage(systemName: "circle.fill")
        pageControl.currentPageIndicatorTintColor = .systemBlue
        return pageControl
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.tintColor = .white
        button.layer.cornerRadius = 44 / 2
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()
    
    func createEmojiButtons(image: UIImage) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(chooseEmoji), for: .touchUpInside)
        return button
    }
    
    lazy var firstEmojiButton = createEmojiButtons(image: UIImage(named: "emoji-1")!)
    lazy var secondEmojiButton = createEmojiButtons(image: UIImage(named: "emoji-2")!)
    lazy var therdEmojiButton = createEmojiButtons(image: UIImage(named: "emoji-3")!)
    lazy var forthEmojiButton = createEmojiButtons(image: UIImage(named: "emoji-4")!)
    lazy var fifthEmojiButton = createEmojiButtons(image: UIImage(named: "emoji-5")!)
    lazy var sixthEmojiButton = createEmojiButtons(image: UIImage(named: "emoji-6")!)
    lazy var seventhEmojiButton = createEmojiButtons(image: UIImage(named: "emoji-7")!)
    lazy var eghthEmojiButton = createEmojiButtons(image: UIImage(named: "emoji-8")!)

    
    lazy var situationTextField = createTextFields(with: "Опишите ситуацию")
    lazy var thoughtsTextField = createTextFields(with: "Опишите Ваши мысли")
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
        textField.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.backward.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    @objc func chooseEmoji(sender: UIButton) {
        activityTypeButtons.forEach { button in
            button.backgroundColor = .secondarySystemBackground
        }
        sender.backgroundColor = .systemGray
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
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .title2)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
        
        activityTypeButtons = [firstEmojiButton, secondEmojiButton, therdEmojiButton, forthEmojiButton, fifthEmojiButton, sixthEmojiButton, seventhEmojiButton, eghthEmojiButton]
    }
    
    private func setTags() {
        for (index, button) in activityTypeButtons.enumerated() {
            button.tag = index
        }
    }
    
    // MARK: - Settings
    
    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        selectedIndex = 0
        

    }
    
    private func setupHierarchy() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        view.addSubview(closeButton)
        view.addSubview(backButton)
        view.addSubview(label)
        view.addSubview(datePicker)
        
        view.addSubview(emojiTopStackView)
        emojiTopStackView.addArrangedSubview(firstEmojiButton)
        emojiTopStackView.addArrangedSubview(secondEmojiButton)
        emojiTopStackView.addArrangedSubview(therdEmojiButton)
        emojiTopStackView.addArrangedSubview(forthEmojiButton)
        
        view.addSubview(emojiBottomStackView)
        emojiBottomStackView.addArrangedSubview(fifthEmojiButton)
        emojiBottomStackView.addArrangedSubview(sixthEmojiButton)
        emojiBottomStackView.addArrangedSubview(seventhEmojiButton)
        emojiBottomStackView.addArrangedSubview(eghthEmojiButton)

        view.addSubview(situationTextField)
        view.addSubview(thoughtsTextField)
        view.addSubview(emotionsTextField)
        view.addSubview(reactionTextField)
    }
    
    private func setupLayout() {
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.left.equalTo(view.snp.left).offset(40)
            make.right.equalTo(view.snp.right).offset(-40)
            make.bottom.equalTo(view.snp.bottom).offset(-200)
        }
        
        pageControl.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(40)
            make.right.equalTo(view.snp.right).offset(-40)
            make.bottom.equalTo(nextButton.snp.top).offset(-40)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
       //1
        label.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(150)
            make.centerX.equalTo(view.snp.centerX)
            make.leading.equalTo(view.snp.leading).offset(35)
            make.trailing.equalTo(view.snp.trailing).offset(-35)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(80)
            make.centerX.equalTo(view.snp.centerX).offset(-10)
        }
        
        //2
        emojiTopStackView.snp.makeConstraints { make in
            make.bottom.equalTo(emojiBottomStackView.snp.top).offset(-40)
            make.centerX.equalTo(view.snp.centerX)
        }
        emojiBottomStackView.snp.makeConstraints { make in
            make.bottom.equalTo(pageControl.snp.top).offset(-80)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        //3
        situationTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(40)
            make.right.equalTo(view.snp.right).offset(-40)
        }
        //4
        thoughtsTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(40)
            make.right.equalTo(view.snp.right).offset(-40)
        }
        //5
        emotionsTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(40)
            make.right.equalTo(view.snp.right).offset(-40)
        }
        //6
        reactionTextField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(40)
            make.right.equalTo(view.snp.right).offset(-40)
        }
    }
}

// MARL: - Action
extension NewEntryView {
    @objc private func nextButtonAction() {
        selectedIndex += 1
        pageControl.currentPage += 1
    }
    
    @objc func backAction() {
        selectedIndex -= 1
        pageControl.currentPage -= 1
    }
}

