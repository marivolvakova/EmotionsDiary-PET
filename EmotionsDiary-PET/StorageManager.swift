//
//  StorageManager.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 31.10.2022.
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

class StorageManager {
    
    let realm = try! Realm()
    var items: Results<Event>!
    
    static let shared = StorageManager()
    
    // MARK: - Обращание к хранилищу
    func makeStorage() {
        items = realm.objects(Event.self)
    }

    // MARK: - Добавление данных
    func addEvent(_ event: Event) {
        try! self.realm.write({
            self.realm.add(event)
            print("Event has ben added")
        })
    }

    // MARK: - Удаление данных
    func deleteEvent(_ event: Event) {
        try! self.realm.write {
            self.realm.delete(event)
            print("Event has ben deleted")
        }
    }
    
    func deleteAllEvents()  {
        try! self.realm.write {
            self.realm.deleteAll()
            print("All events has ben deleted")
         }
    }
}
