//
//  StorageManager.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 31.10.2022.
//

import RealmSwift

class StorageManager {
    
    let realm = try! Realm()
    var items: Results<Event>!
    
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
    
    // MARK: - Удаление всех данных
    
    func deleteAllEvents()  {
        try! self.realm.write {
            self.realm.deleteAll()
            print("All events has ben deleted")
         }
    }
}
