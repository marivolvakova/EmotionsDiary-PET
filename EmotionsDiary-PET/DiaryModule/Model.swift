//
//  Model.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 29.10.2022.
//

import Foundation

struct EventModel {
    let name: String
    let description: String
    let date: Date
    let colorGroup: ColorGroups
    
    enum ColorGroups: CaseIterable {
        case groupCall
        case newConspect
        case homeworkOpen
        case homeworkDeadline
    }
}

class EventsList {
    
    var events: [EventModel] = { [
        EventModel(name: "Созвон", description: "Обертки свойств и анимация в SwiftUI", date: String("30.09.2022, 19:00").convertToDate()!, colorGroup: .groupCall),
        EventModel(name: "Созвон", description: "Обертки свойств и анимация в SwiftUI", date: String("07.10.2022, 19:00").convertToDate()!, colorGroup: .groupCall),
        EventModel(name: "Созвон", description: "Обертки свойств и анимация в SwiftUI", date: String("14.10.2022, 19:00").convertToDate()!, colorGroup: .groupCall),
        EventModel(name: "Созвон", description: "Обертки свойств и анимация в SwiftUI", date: String("21.10.2022, 19:00").convertToDate()!, colorGroup: .groupCall),
        EventModel(name: "Созвон", description: "Обертки свойств и анимация в SwiftUI", date: String("28.10.2022, 19:00").convertToDate()!, colorGroup: .groupCall),
        
        EventModel(name: "Новый конспект", description: "Тема 3: Массивы, наборы и словари", date: String("12.10.2022, 00:00").convertToDate()!, colorGroup: .newConspect),
        
        EventModel(name: "Открыто новое ДЗ", description: "Домашнее задание 13", date: String("05.10.2022, 00:00").convertToDate()!, colorGroup: .homeworkOpen),
        EventModel(name: "Дедлайн по ДЗ", description: "Домашнее задание 13", date: String("10.10.2022, 23:59").convertToDate()!, colorGroup: .homeworkDeadline)
        ]
    }()
}
