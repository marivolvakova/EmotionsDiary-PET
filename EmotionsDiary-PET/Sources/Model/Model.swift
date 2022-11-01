//
//  Model.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 01.11.2022.
//
import Foundation
import RealmSwift

class Event: Object {
    @Persisted var date: Date
    @Persisted var situation: String
    @Persisted var thoughts: String
    @Persisted var emotions: String
    @Persisted var reaction: String
}
