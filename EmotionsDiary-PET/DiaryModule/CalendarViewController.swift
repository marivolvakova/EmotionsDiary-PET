//
//  ViewController.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 29.10.2022.
//

import UIKit
import FSCalendar
import SnapKit


class CalendarViewController: UIViewController {
    
    // MARK: - Properties
    
    private var calendarView: CalendarView? {
        guard isViewLoaded else { return nil }
        return view as? CalendarView
    }
    
    private var model = [Event]()
    
    var storageManager = StorageManager.shared
    
    var selectedDate = Date()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = CalendarView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView?.tableView.reloadData()
        setupView()
        storageManager.makeStorage()
    }
    
    // MARK: - Setup functions
    
    private func setupView() {
        calendarView?.tableView.dataSource = self
        calendarView?.tableView.delegate = self
        calendarView?.segmentControl.addTarget(self, action: #selector(controlDidChanged(_:)), for: .valueChanged)
        
        calendarView?.mainSegmentControl.addTarget(self, action: #selector(mainControlDidChanged(_:)), for: .valueChanged)
        
        calendarView?.calendar.delegate = self
        calendarView?.calendar.dataSource = self
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "text.alignleft"), style: .plain, target: self, action: #selector(showSettings))
        leftBarButton.tintColor = .black
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(makeNewEntry))
        rightBarButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    // MARK: - Functions
    
    @objc func controlDidChanged(_ segmentControl: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            calendarView?.calendar.setScope(.month, animated: true)
        } else if segmentControl.selectedSegmentIndex == 1 {
            calendarView?.calendar.setScope(.week, animated: true)
        }
    }
    
    @objc func mainControlDidChanged(_ segmentControl: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            calendarView?.calendar.isHidden = true
            calendarView?.lineView.isHidden = true
            calendarView?.titleLentaLabel.isHidden = false
            calendarView?.remakeTablViewConstraints()
        } else if segmentControl.selectedSegmentIndex == 1 {
            calendarView?.calendar.isHidden = false
            calendarView?.lineView.isHidden = false
            calendarView?.titleLentaLabel.isHidden = true
            calendarView?.remakeTablViewConstraints()
        }
    }
    
    func eventsForDate(date: Date) -> [Event]  {
        var daysEvents = [Event]()
        for event in storageManager.items {
            if Calendar.current.isDate(event.date, inSameDayAs: date) {
                daysEvents.append(event)
            }
        }
        return daysEvents
    }
    
    @objc func showSettings() {
        self.present(calendarView!.settingsView, animated: true)
    }
    
    @objc func makeNewEntry() {
        let modalController = NewEntryViewController()
        modalController.modalPresentationStyle = .formSheet
        modalController.sheetPresentationController?.detents = [.large()]
        modalController.sheetPresentationController?.prefersGrabberVisible = true
        present(modalController, animated: true)
    }
}

// MARK: - FSCalendarDelegate

extension CalendarViewController: FSCalendarDelegate {
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date.convertToString())
        selectedDate = date
        calendarView?.tableView.reloadData()
    }
}

// MARK: - FSCalendarDelegateAppearance

extension CalendarViewController: FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarView?.remakeCalendarConstraints(bounds: bounds)
    }
}

extension CalendarViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
var dates = [Date]()
        for event in storageManager.items {
            dates.append(event.date)
        }
        
        if dates.contains(date) {
            return 1
        }
        return 0
    }
}
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        var returnValue = UIImage()
//        for event in EventsList().events {
//            if Calendar.current.isDate(event.date, inSameDayAs: date) {
//                switch event.colorGroup {
//                case .groupCall:
//                    returnValue = UIImage(systemName: "circle.dotted")!
//                case .newConspect:
//                    returnValue = UIImage(systemName: "circle.dotted")!
//                case .homeworkOpen:
//                    returnValue = UIImage(systemName: "circle.dotted")!
//                case .homeworkDeadline:
//                    returnValue = UIImage(systemName: "circle.dotted")!
//                }
//            }
//        }
//        return returnValue
//    }

///Метод для создания цветных иконок

//        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//
//            let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
//
//            for event in EventsList().events {
//                if Calendar.current.isDate(event.date, inSameDayAs: date) {
//                    switch event.colorGroup {
//                    case .homeworkDeadline:
//                        cell.contentView.tintColor = .red
//                    case .homeworkOpen:
//                        cell.contentView.tintColor = .systemBrown
//                    case .newConspect:
//                        cell.contentView.tintColor = .purple
//                    case .groupCall:
//                        cell.contentView.tintColor = .gray
//                    }
//                }
//            }
//            return cell
//        }


// MARK: - UITableViewDataSource

extension CalendarViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var daysEvents = [Event]()
        for event in storageManager.items {
            if Calendar.current.isDate(event.date, inSameDayAs: selectedDate) {
                daysEvents.append(event)
            }
        }
        return daysEvents.count > 0 ? daysEvents.count : 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var daysEvents = [Event]()
        for event in storageManager.items {
            if Calendar.current.isDate(event.date, inSameDayAs: selectedDate) {
                daysEvents.append(event)
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: indexPath) as! CalendarCell
        
        if daysEvents.count > 0 {
            cell.timeLable.text = daysEvents[indexPath.row].date.convertToString()
            cell.situationLable.text = daysEvents[indexPath.row].situation
            cell.emotionsLable.text = daysEvents[indexPath.row].emotions
            cell.backgroundColor = .white
            cell.selectionStyle = .blue
        } else {
            cell.situationLable.text = "Создайте свою первую запись нажав на полюс в правом верхнем углу!"
        }

        return cell
    }
}


extension CalendarViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "334fjgj"
    }
}
