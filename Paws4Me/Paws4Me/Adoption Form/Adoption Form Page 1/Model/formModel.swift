//
//  formModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/01.
//

import Foundation

enum CellType {
    case inputValue
    case booleanValue
    case multiSelectValue
    case imageSelect
}

enum Images: String {
    case titleImg = ""
    case farm = "farm"
    case home = "home"
    case flat = "flat"
    case petSitter = "pet_Sitter"
    case takeWith = "suitcase"
    case kennel = "kennel"
    case family = "family"
}

struct FormStructure {
    var sectionIndex: Int?
    var cellIndex: Int?
    var data: CellData?
}

struct CellData {
    var cellStructure: CellType
    var isChecked: Bool?
    var itemTitle: String?
    var itemValue: String?
    var itemName: String?
    var itemImage: Images?
    var itemCount: [CellType] = [.multiSelectValue, .booleanValue, .inputValue]
}
