//
//  SettingsModalViewController.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 30.10.2022.
//

import UIKit
import SnapKit
import FSCalendar


class SettingsModalViewController: UIViewController {
    
    lazy var toggle = UISwitch()
    
    let parentView = CalendarView()
    
    lazy var calendarViewLable: UILabel = {
        let label = UILabel()
        label.text = "Отображение"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["МЕСЯЦ", "НЕДЕЛЯ"])
        segmentControl.selectedSegmentTintColor = UIColor(red: 8 / 255, green: 232 / 255, blue: 222 / 255, alpha: 1)
        segmentControl.backgroundColor = .systemGroupedBackground
        segmentControl.selectedSegmentIndex = 1
        return segmentControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    func setupView() {
        view.backgroundColor = .white
        segmentControl.addTarget(self, action: #selector(controlDidChanged(_:)), for: .valueChanged)
        parentView.calendar.delegate = self
    }
    
    func setupHierarchy() {
        view.addSubview(segmentControl)
    }
    
    func setupLayout() {
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(150)
            make.left.equalTo(view.snp.left).offset(15)
            make.width.equalTo(140)
        }
    }
    
    @objc func controlDidChanged(_ segmentControl: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 1 {
                parentView.calendar.setScope(.month, animated: true)
            parentView.calendar.reloadData()
        } else if segmentControl.selectedSegmentIndex == 0 {
            parentView.calendar.setScope(.week, animated: true)
            parentView.calendar.reloadData()
        }
    }
    

}

// MARK: - FSCalendarDelegateAppearance

extension SettingsModalViewController: FSCalendarDelegateAppearance {

func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    parentView.remakeCalendarConstraints(bounds: bounds)
}
}
