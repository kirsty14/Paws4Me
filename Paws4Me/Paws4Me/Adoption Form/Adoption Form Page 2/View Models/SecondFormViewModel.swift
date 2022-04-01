//
//  SecondFormViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/01.
//

import Foundation

class SecondFormViewModel {

    // : MARK: - Var/Lets
    var formArray: [FormStructure] = [
        FormStructure(sectionIndex: 0, cellIndex: 0, data: CellData(cellStructure: .imageSelect,
                                                                    itemTitle: "Which one describes your home",
                                                                    itemName: "titleImg",
                                                                    itemImage: .titleImg)),
        FormStructure(sectionIndex: 0, cellIndex: 1, data: CellData(cellStructure: .imageSelect,
                                                                    itemName: "flat",
                                                                    itemImage: .flat)),
        FormStructure(sectionIndex: 0, cellIndex: 2, data: CellData(cellStructure: .imageSelect,
                                                                    itemName: "home",
                                                                    itemImage: .home)),
        FormStructure(sectionIndex: 0, cellIndex: 3, data: CellData(cellStructure: .imageSelect,
                                                                    itemName: "farm",
                                                                    itemImage: .farm)),

        FormStructure(sectionIndex: 1, cellIndex: 0, data: CellData(cellStructure: .imageSelect,
                                                                    itemTitle: "Who cares for the pet when away",
                                                                    itemName: "titleImg",
                                                                    itemImage: .titleImg)),
        FormStructure(sectionIndex: 1, cellIndex: 1, data: CellData(cellStructure: .imageSelect,
                                                                    itemName: "family",
                                                                    itemImage: .family)),
        FormStructure(sectionIndex: 1, cellIndex: 2, data: CellData(cellStructure: .imageSelect,
                                                                    itemName: "kennel",
                                                                    itemImage: .kennel)),
        FormStructure(sectionIndex: 1, cellIndex: 3, data: CellData(cellStructure: .imageSelect,
                                                                    itemName: "pet sitter",
                                                                    itemImage: .petSitter)),
        FormStructure(sectionIndex: 1, cellIndex: 4, data: CellData(cellStructure: .imageSelect,
                                                                    itemName: " Take with",
                                                                    itemImage: .takeWith))
    ]

    private var section: Int = 0

    func setSection(sectionNumber: Int) {
         section = sectionNumber
    }

    var arrayForm: [FormStructure] {
        return formArray
    }
}
