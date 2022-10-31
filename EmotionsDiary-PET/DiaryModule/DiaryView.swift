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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.tintColor = .white
        tableView.backgroundColor = .placeholderText
        tableView.separatorColor = .darkGray
        tableView.separatorInsetReference = .fromCellEdges
        tableView.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
        tableView.rowHeight = 50
        return tableView
    }()
    
    let calendar: FSCalendar = {
        let calendar = FSCalendar()
        //calendar.setScope(.week, animated: true)
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
    }
    
    func setupLayout() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(50)
            make.left.equalTo(snp.left).offset(5)
            make.right.equalTo(snp.right).offset(-5)
            make.height.equalTo(250)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(15)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-15)
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





