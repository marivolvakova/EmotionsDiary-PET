//
//  Model.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 16.11.2022.
//

import UIKit

struct NewEntry {
    let datePicker: UIDatePicker?
    let title: String
    let placeholderText: String
    let textField: UITextField?
}

class NewEntryModel {
    let items: [NewEntry] = {
        [
            NewEntry(datePicker: UIDatePicker(), title: "Выберете дату и время события", placeholderText: "Опишите ситуацию", textField: nil),
            NewEntry(datePicker: nil, title: "Ситуация", placeholderText: "Опишите ситуацию", textField: UITextField())

        ]
    }()
}
