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
    
    lazy var settingsView: UIViewController = {
        let view = UIViewController()
        view.modalPresentationStyle = .formSheet
        view.sheetPresentationController?.detents = [.medium()]
        view.sheetPresentationController?.prefersGrabberVisible = true
        view.sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = false
        view.view.backgroundColor = .white
        return view
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
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Месяц", "Неделя"])
        segmentControl.selectedSegmentTintColor = UIColor(red: 8 / 255, green: 232 / 255, blue: 222 / 255, alpha: 1)
        segmentControl.backgroundColor = .systemGroupedBackground
        segmentControl.selectedSegmentIndex = 1
        return segmentControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.tintColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.separatorInsetReference = .fromCellEdges
        tableView.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
        tableView.rowHeight = 50
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
        addSubview(tableView)
        settingsView.view.addSubview(calendarViewLable)
        settingsView.view.addSubview(segmentControl)
    }
    
    func setupLayout() {
        calendarViewLable.snp.makeConstraints { make in
            make.top.equalTo(settingsView.view.snp.top).offset(30)
            make.left.equalTo(settingsView.view.snp.left).offset(20)
        }

        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(calendarViewLable.snp.bottom).offset(10)
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.left.equalTo(snp.left).offset(15)
            make.right.equalTo(snp.right).offset(-15)
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
}





