//
//  PresentdtionController.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 11.11.2022.
//
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    // MARK: Properties
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    let calendarView = CalendarView()
    
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
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
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
    
    let topView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        return view
    }()
    
    let topDarkLine: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 3
        return view
    }()
    
    override func viewDidLayoutSubviews() {
         if !hasSetPointOrigin {
             hasSetPointOrigin = true
             pointOrigin = self.view.frame.origin
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    func setupViews() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        topView.addGestureRecognizer(panGesture)

    }
    
    func setupHierarchy() {
        view.addSubview(topView)
        topView.addSubview(topDarkLine)
        view.addSubview(closeButton)
        view.addSubview(calendarViewLable)
        view.addSubview(segmentControl)
        view.addSubview(mainSegmentControl)
    }
    
    @objc func closeView() {
        self.dismiss(animated: true)
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }

        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)

        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                // Velocity fast enough to dismiss the uiview
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    func setupLayout() {
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        topDarkLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(6)
            make.width.equalToSuperview().multipliedBy(0.15)
            make.centerX.equalToSuperview()
        }
        calendarViewLable.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(calendarViewLable.snp.bottom).offset(15)
            make.width.equalTo(350)
            make.height.equalTo(35)
            make.centerX.equalTo(view.snp.centerX)
        }
        mainSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(15)
            make.width.equalTo(350)
            make.height.equalTo(35)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
