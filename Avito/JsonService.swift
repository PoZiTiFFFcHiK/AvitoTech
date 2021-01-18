//
//  JsonService.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//

import Foundation

struct Services: Decodable {
    let status: String
    let result: Result
}

struct Result: Decodable {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    let list: [List]
}

struct List: Decodable {
    let id: String
    let title: String
    let description: String?
    let icon: Icon
    let price: String
    let isSelected: Bool
}

struct Icon: Decodable {
    let URL: String
    enum CodingKeys: String, CodingKey {
        case URL = "52x52"
    }
}

class JSON {
    let name: String
    
    init(fileName: String) {
        self.name = fileName
    }
    private func getDataFromLocalFile(name: String) -> Data? {
        do {
            if let path = Bundle.main.path(forResource: name, ofType: "json"), let jsonData = try String(contentsOfFile: path).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func getJsonFromFile(result: @escaping ((Services)->Void)) {
        guard let data = getDataFromLocalFile(name: name) else { return }
        do {
            let dataFromJson = try JSONDecoder().decode(Services.self, from: data)
            result(dataFromJson)
        } catch {
            print(error)
        }
    }
}
