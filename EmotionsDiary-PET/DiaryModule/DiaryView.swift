//
//  DiaryView.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 29.10.2022.
//
import UIKit
import FSCalendar
import SnapKit

class CalendarView: UIView {
    
    // MARK: - Properties
    
    
    lazy var formatter = DateFormatter()
    
    let settingsView: UIViewController = {
        let view = UIViewController()
        view.modalPresentationStyle = .pageSheet
        view.sheetPresentationController?.detents = [.medium()]
        view.sheetPresentationController?.prefersGrabberVisible = true
        view.sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = false
        view.view.backgroundColor = .white
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLentaLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Лента записей"
        label.font = .preferredFont(forTextStyle: .title1)
        label.isHidden = true
        return label
    }()
    
    lazy var toggle = UISwitch()
    
    lazy var calendarViewLable: UILabel = {
        let label = UILabel()
        label.text = "Отображение"
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    @objc func closeView() {
        settingsView.dismiss(animated: true)
    }
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Месяц", "Неделя"])
        segmentControl.selectedSegmentTintColor = UIColor(red: 103 / 255, green: 112 / 255, blue: 241 / 255, alpha: 1)
        segmentControl.backgroundColor = .systemGroupedBackground
        segmentControl.selectedSegmentIndex = 1
        return segmentControl
    }()
    
    lazy var mainSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Лента", "Календарь"])
        segmentControl.selectedSegmentTintColor = UIColor(red: 103 / 255, green: 112 / 255, blue: 241 / 255, alpha: 1)
        segmentControl.backgroundColor = .systemGroupedBackground
        segmentControl.selectedSegmentIndex = 1
        return segmentControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.tintColor = .black
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.separatorInsetReference = .fromCellEdges
        tableView.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
        tableView.rowHeight = 100
        return tableView
    }()
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.setScope(.week, animated: true)
        calendar.scrollDirection = .horizontal
        calendar.appearance.weekdayTextColor = UIColor(red: 103 / 255, green: 112 / 255, blue: 241 / 255, alpha: 1)
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.todayColor = .systemBlue
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16)
        calendar.appearance.headerDateFormat = "LLLL, yyyy"
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 20, weight: .bold)
        calendar.appearance.headerTitleColor = UIColor(red: 103 / 255, green: 112 / 255, blue: 241 / 255, alpha: 1)
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.headerTitleOffset = CGPoint(x: 0, y: -5)
        calendar.collectionView.tintColor = .orange
        calendar.appearance.selectionColor = .lightGray
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.allowsMultipleSelection = false
        calendar.firstWeekday = 2
        calendar.placeholderType = .fillSixRows
        calendar.backgroundColor = .white
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        return calendar
    }()
    
    // MARK: - Initial
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupHierarchy() {
        addSubview(calendar)
        addSubview(lineView)
        addSubview(tableView)
        addSubview(titleLentaLabel)
        
        settingsView.view.addSubview(closeButton)
        settingsView.view.addSubview(calendarViewLable)
        settingsView.view.addSubview(segmentControl)
        
        settingsView.view.addSubview(mainSegmentControl)
        
    }
    
    func setupLayout() {
        calendarViewLable.snp.makeConstraints { make in
            make.top.equalTo(settingsView.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.equalTo(settingsView.view.snp.left).offset(20)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(settingsView.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalTo(settingsView.view.snp.right).offset(-20)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(calendarViewLable.snp.bottom).offset(15)
            make.width.equalTo(350)
            make.height.equalTo(35)
            make.centerX.equalTo(settingsView.view.snp.centerX)
        }
        mainSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(15)
            make.width.equalTo(350)
            make.height.equalTo(35)
            make.centerX.equalTo(settingsView.view.snp.centerX)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(50)
            make.left.equalTo(snp.left).offset(5)
            make.right.equalTo(snp.right).offset(-5)
            make.height.equalTo(250)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.top).offset(-1)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        titleLentaLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(60)
            make.centerX.equalTo(snp.centerX)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(10)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
    }
    
    func remakeCalendarConstraints(bounds: CGRect) {
        calendar.snp.remakeConstraints { make in
            make.top.equalTo(snp.top).offset(60)
            make.left.equalTo(snp.left).offset(5)
            make.right.equalTo(snp.right).offset(-5)
            make.height.equalTo(Int(bounds.height))
        }
    }
    
    func remakeTablViewConstraints() {
        if mainSegmentControl.selectedSegmentIndex == 0 {
            tableView.snp.remakeConstraints { make in
                make.top.equalTo(snp.top).offset(20)
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right)
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            }
        } else if mainSegmentControl.selectedSegmentIndex == 1 {
            tableView.snp.remakeConstraints { make in
                make.top.equalTo(calendar.snp.bottom).offset(10)
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right)
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            }
        }
    }
}






