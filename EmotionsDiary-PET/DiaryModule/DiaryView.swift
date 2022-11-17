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
    var networkManager = NetworkManager.shared
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.layer.masksToBounds = true
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
    
    lazy var quoteText: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .footnote)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.sizeToFit()
        return label
    }()
    lazy var quoteAuthor: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .footnote)
        label.clipsToBounds = true
        return label
    }()
    
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()
    
     var quoateView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
         //view.addBlurEffect()
         //view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var toggle = UISwitch()

    @objc private func buttonPressed() {
        networkManager.fetchData()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.tintColor = .black
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.separatorInsetReference = .fromCellEdges
        tableView.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
        tableView.rowHeight = 80
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
        fetchImage()
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
        addSubview(quoateView)
        quoateView.addSubview(quoteText)
        quoateView.addSubview(quoteAuthor)
    }
    
    func setupLayout() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(5)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        quoateView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).offset(-20)
            make.height.equalTo(95)
        }
        quoteText.snp.makeConstraints { make in
            make.top.equalTo(quoateView.snp.top).offset(1)
            make.left.equalTo(quoateView.snp.left).offset(10)
            make.right.equalTo(quoateView.snp.right).offset(-10)
            make.height.equalTo(70)
        }
        quoteAuthor.snp.makeConstraints { make in
            make.top.equalTo(quoteText.snp.bottom).offset(2)
            make.centerX.equalTo(quoateView.snp.centerX)
            make.height.equalTo(20)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(50)
            make.left.equalTo(snp.left).offset(5)
            make.right.equalTo(snp.right).offset(-5)
            make.height.equalTo(250)
        }
        
        titleLentaLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(60)
            make.centerX.equalTo(snp.centerX)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(quoateView.snp.bottom).offset(10)
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
        if SettingsViewController().mainSegmentControl.selectedSegmentIndex == 0 {
            tableView.snp.remakeConstraints { make in
                make.top.equalTo(titleLentaLabel.snp.bottom).offset(15)
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right)
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            }
        } else if SettingsViewController().mainSegmentControl.selectedSegmentIndex == 1 {
            tableView.snp.remakeConstraints { make in
                make.top.equalTo(quoteAuthor.snp.bottom).offset(10)
                make.left.equalTo(snp.left)
                make.right.equalTo(snp.right)
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
            }
        }
    }
}



extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        self.layer.addSublayer(gradient)
    }
}


extension UIView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}


                                             
                                             
                                             
                                             
extension CalendarView {
            func fetchImage() {
                guard let url = URL(string: "https://catherineasquithgallery.com/uploads/posts/2021-02/1613391002_151-p-fon-dlya-prezentatsii-estetika-bezhevogo-178.jpg") else { return }
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if error != nil {
                        fatalError("ERROR IN URL")
                    } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        guard let data = data else { return }
                        DispatchQueue.main.async {
                            self.quoateView.backgroundColor = UIColor(patternImage: UIImage(data: data)!)
                        }
                    }
                }.resume()
            }
            
}
