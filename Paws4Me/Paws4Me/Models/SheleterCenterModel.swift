//
//  SheleterCenterModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation

struct Center: Codable {
    let city: String?
    let id: Int?
    let lat, lon: Double?
    let name, services, state, zipcode: String?
}
