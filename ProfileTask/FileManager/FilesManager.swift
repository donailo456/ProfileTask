//
//  FilesManager.swift
//  ProfileTask
//
//  Created by Danil Komarov on 29.03.2024.
//

import Foundation

final class FilesManager {
    
    private enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
    }
    
    static let shared = FilesManager()
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func createFile(_ data: [Service]?) {
        guard FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first != nil else {
            fatalError("\(Error.invalidDirectory)")
        }
        
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("data.json")
        
        print("Path to file: \(filePath)")
        
        guard let dataSource = data else { fatalError("\(Error.fileAlreadyExists)") }

        do {
            let data = try encoder.encode(dataSource)
            try data.write(to: filePath)
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    func readFile(complition: ([Service]?) -> Void) {
        guard let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("data.json") else {
            fatalError("\(Error.writtingFailed)")
        }
        
        var service: [Service]? = []
        
        do {
            let data = try Data(contentsOf: filePath)
            let dataSource = try decoder.decode([Service].self, from: data)
            
            dataSource.forEach{ item in
                service?.append(item)
            }
            
            complition(service)
        } catch {
            print("Failed to read file: \(error.localizedDescription)")
        }
        
    }
}
