//
//  BaseRepository.swift
//  Test-tableView
//
//  Created by Matin on 2023-12-13.
//

import Foundation

protocol ApplicationRepositoryProtocol {
    func readLocalJSONFile(forName name: String) -> Data?
    func decodedData<T: Decodable>(resourceName: String) -> [T]
}

extension ApplicationRepositoryProtocol {
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("Error reading JSON file: \(error)")
        }
        return nil
    }
    
    func decodedData<T: Decodable>(resourceName: String) -> [T] {
        if let productsData = readLocalJSONFile(forName: resourceName) {
            do {
                let decoder = JSONDecoder()
                let decodedObjects = try decoder.decode([T].self, from: productsData)
                let decodedOjectsArray: [T] = decodedObjects
                return decodedOjectsArray
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return []
    }
    
    func decodedOrderData<T: Decodable>(resourceName: String) -> T? {
        if let productsData = readLocalJSONFile(forName: resourceName) {
            do {
                let decoder = JSONDecoder()
                let decodedObjects = try decoder.decode(T.self, from: productsData)
                let decodedOjectsArray: T = decodedObjects
                return decodedOjectsArray
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return nil
    }
}
