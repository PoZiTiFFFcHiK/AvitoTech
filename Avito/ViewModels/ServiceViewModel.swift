//
//  ServiceViewModel.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//

import Foundation

struct ServiceInfo {
    let id: String
    let title: String
    let description: String?
    let icon: String
    let price: String
    let isSelected: Bool
    
    init(serviceData: List) {
        self.id = serviceData.id
        self.title = serviceData.title
        self.description = serviceData.description
        self.icon = serviceData.icon.URL
        self.price = serviceData.price
        self.isSelected = serviceData.isSelected
    }
}

