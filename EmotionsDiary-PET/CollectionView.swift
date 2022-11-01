//
//  CollectionView.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 01.11.2022.
//
//
//import UIKit
//
//
//struct Event {
// var date: String
// var situation: String
// var thoughts: String
// var emotions: String
//var reaction: String
//}
//
//class CollectionViewController: UIViewController {
//    
//    var collectionView: UICollectionView!
//    
//    let model: [Event] = {
//        [
//            Event(date: "15.07.2022", situation: "11111111", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "22222222", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "33333333", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "444444444", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "555555555", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "66666666", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "777777777", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "88888888", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "99999999", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh"),
//            Event(date: "15.07.2022", situation: "10101010101010", thoughts: "245tgy", emotions: "245gh", reaction: "24tgh")
//        ]
//    }()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureCollectionViewLayout()
//    }
//    
//    func configureCollectionViewLayout() {
//        
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
//        view.addSubview(collectionView)
//        
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        
//        collectionView.backgroundColor = .systemBackground
//        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        
//        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
//        collectionView.register(CalendarTypeCell.self, forCellWithReuseIdentifier: CalendarTypeCell.identifier)
//        
//    }
//    // MARK: - CreateLayout
//    func createLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//            
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                  heightDimension: .absolute(100))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                   heightDimension: .fractionalHeight(1))
//            
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//
//            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//            let section = NSCollectionLayoutSection(group: group)
//            return section
//        }
//        return layout
//    }
//}
//
//extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return model.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let info = model[indexPath.row]
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarTypeCell.identifier, for: indexPath) as! CalendarTypeCell
//        cell.situationLable.text = info.situation
//            return cell
//    }
//    
//    
////    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        //let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as! SectionHeader
////    }
//}
